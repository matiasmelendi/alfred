require 'spec_helper'

describe "MyController" do
  let!(:current_course) { Factories::Course.algorithm }
  let(:current_account) { Factories::Account.student }

  before (:each) do
    Alfred::App.any_instance.stub(:current_account).and_return(current_account)
  end

  describe "get profile" do
    it "should render profile view" do
      Alfred::App.any_instance.should_receive(:render)
        .with('my/profile')

      get "/my/profile"

      last_response.should be_ok
    end
  end

  describe 'update profile' do
    let(:updated_name) { 'Johnny' }
    let(:updated_surname) { 'Be Good' }
    let(:updated_tag) { 'vie' }
    let(:updated_password) { 'new+password' }

    it "should update fields without modifying password" do
      current_account.should_receive(:update).with({ 'name' => updated_name, 'surname' => updated_surname, 'tag' => updated_tag }).and_return(true)

      put '/my/profile', account: { name: updated_name, surname: updated_surname, tag: updated_tag, password: '', password_confirmation: '' }
    end

    it "should update fields and password" do
      current_account.should_receive(:update).with({ 'name' => updated_name, 'surname' => updated_surname, 'tag' => updated_tag, 'password' => updated_password, 'password_confirmation' => updated_password }).and_return(true)

      put '/my/profile', account: { name: updated_name, surname: updated_surname, tag: updated_tag, password: updated_password, password_confirmation: updated_password }
    end
  end

  describe "course enrollment" do
    let(:new_course) { Factories::Course.name( '2013-2c') }

    describe "student is recurrent" do
      it "should enroll student in a new course" do

        expect(current_account.courses).not_to include( new_course )

        put 'my/profile',                                               \
          { "account"=>                                                 \
              { "name"=>"student201314",                                \
                "surname"=>"soy recursante",                            \
                "tag"=>"mie",                                           \
                "active_course"=> new_course.id                         \
          }                                                             \
        }

        expect( current_account.is_enrolled?(current_course) ).to be true
        expect( current_account.is_enrolled?(new_course) ).to be true

      end
    end
  end
end 
