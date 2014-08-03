require 'spec_helper'

describe "AccountsController" do
  let(:student_name)      { 'Carles' }
  let(:student_surname)   { 'Darwin' }
  let(:student_buid)      { '00001' }
  let(:student_email)     { 'charlesdarwin@student.com' }
  let(:student_tag)       { '' }
  let(:student_pass)      { 'foobar' }
  let(:course)            { Factories::Course.algorithm }

  describe "register" do
    let(:new_student) do
      { account: {
        :name => student_name,
        :surname => student_surname,
        :buid => student_buid,
        :email => student_email,
        :password => student_pass,
        :password_confirmation => student_pass
      } }
    end

    before :each do
      Course.stub(:active).and_return(course)
    end

    describe "student registers himself with a valid tag" do
      before do
        new_student[:account][:tag] = Account.valid_tags.first
      end

      it "should create a new student" do
        post "/accounts/register", new_student

        Account.all.size.should > 0

        new = Account.all.last
        new.is_student?.should == true
        new.name.should == student_name
        new.surname.should == student_surname
        new.buid.should == student_buid
        new.email.should == student_email
        new.tag.should == Account.valid_tags.first
      end
    end

    describe "student cannot register himself with an invalid tag" do
      before do
        new_student[:account][:tag] = '<invalid tag>'
      end

      it "should not create a new student" do
        post "/accounts/register", new_student

        Account.all.size.should == 0
      end
    end
  end

  describe 'reset_password' do
    it "should redirect to root if user already signed in" do
      Alfred::App.any_instance.stub(:current_account).and_return(double(role: 'student'))

      get '/accounts/reset_password'

      last_response.redirection?.should be_true
      last_response.location.should == 'http://example.org/'
    end

    it "should redirect to root if user already signed in" do
      Alfred::App.any_instance.stub(:current_account).and_return(double(role: 'student'))

      post '/accounts/reset_password', account: {email: 'john@example.org'}

      last_response.redirection?.should be_true
      last_response.location.should == 'http://example.org/'
    end

    it "should display error if email missing" do
      post '/accounts/reset_password'

      last_response.body.should =~ /#{I18n.t('accounts.reset_password.email_required')}/
    end

    it "should display error if cannot find account with given email" do
      post '/accounts/reset_password', account: {email: 'john@example.org'}

      last_response.body.should =~ /#{I18n.t('accounts.reset_password.cannot_find_account_with_email', email: 'john@example.org')}/
    end

    it "should create reset token and send instructions via email" do
      teacher = Factories::Account.teacher
      teacher.reset_password_token.should be_nil
      teacher.reset_password_generated_at.should be_nil

      post '/accounts/reset_password', account: {email: teacher.email}

      pending('Enviar link para setear nuevo password')

      last_response.redirection?.should be_true
      last_response.location.should == 'http://example.org/accounts/login'
      teacher.reload
      teacher.reset_password_token.should_not be_nil
      teacher.reset_password_generated_at.should_not be_nil
    end
  end

end
