require 'spec_helper'

describe "MyController" do
  let(:current_account) { Account.new(name: 'Jane', surname: 'Doe', buid: '1234', role: 'student', tag: 'mie') }

  before (:each) do
    Alfred::App.any_instance.stub(:current_account).and_return(current_account)
    # Alfred::App.any_instance.stub(:current_course)
    #   .and_return(Factories::Course.algorithm)
  end

  describe "get profile" do

    it "should render profile view" do
      Alfred::App.any_instance.should_receive(:render).with('my/profile')

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

  describe 'enroll' do 

    it 'should enroll the current_account in the active course' do
      course = Course.new
      Course.should_receive(:active).and_return(course)
      current_account.should_receive(:enroll).with(course)
      Alfred::App.any_instance.should_receive(:render).with('home/index')
      
      put '/my/enroll'

    end    
  end

    # describe "create solution" do
    #
    #   let(:assignment) { Assignment.create!(name: "TP0", deadline: Date.today) }
    #
    #   let(:params) do
    #     { assignment_id: assignment.id, solution: { comments: [], link: "http://zaraza.com" } }
    #   end
    #
    #   before :each do
    #     Assignment.should_receive(:get).and_return(assignment)
    #   end
    #
    #   context "when a submission date passes and student doesn't upload a solution" do
    #
    #     before :each do
    #       #We do this because the content of my/new_solution.erb raises errors out of this context
    #       Alfred::App.any_instance.should_receive(:render).with('my/new_solution').and_return("")
    #       Timecop.freeze(Date.today + 30)
    #     end
    #
    #     it "should allow students to upload a solution" do
    #       post "/my/assignments/:assignment_id/solutions/create", params
    #
    #       last_response.should be_ok
    #     end
    #
    #   end
    #
    #   context "there is a solution submitted and the student tries to upload another solution for the same assignment" do
    #
    #     before :each do
    #       Solution.create!( account_id: current_account.id,
    #                         assignment: assignment, comments: [],
    #                         link: "http://zaraza.com/home")
    #     end
    #
    #     it "should not allow students to upload a solution" do
    #       post "/my/assignments/:assignment_id/solutions/create", params
    #
    #       last_response.should_not be_ok
    #       last_response.body.should include "La fecha de entrega ha caducado"
    #     end
    #
    #   end
    # end

end
