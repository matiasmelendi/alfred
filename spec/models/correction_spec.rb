require 'spec_helper'

describe Correction do

	before (:each) do
    @correction = Correction.new
	end

	subject { @correction }

	it { should respond_to( :solution ) }
	it { should respond_to( :teacher ) }
	it { should respond_to( :public_comments ) }
	it { should respond_to( :private_comments ) }
	it { should respond_to( :grade ) }

  describe 'approved?' do

    it 'should return false when grade is not defined' do
      correction = Correction.new
      correction.approved?.should be_false
    end

    it 'should return false when grade is less than 4' do
      correction = Correction.new
      correction.grade = 2
      correction.approved?.should be_false
    end

    it 'should return true when grade is 4' do
      correction = Correction.new
      correction.grade = 4
      correction.approved?.should be_true
    end

    it 'should return true when grade is greater then 4' do
      correction = Correction.new
      correction.grade = 5
      correction.approved?.should be_true
    end
  end

  describe 'status' do

    it 'should return :correction_in_progress when grade is not set' do
      @correction.grade = nil
      @correction.status.should eq :correction_in_progress
    end

    it 'should return  :correction_failed when grade is set and less than 4' do
      @correction.grade = 1
      @correction.status.should eq :correction_failed
    end

    it 'should return  :correction_passed when grade is set and greated than 4' do
      @correction.grade = 7
      @correction.status.should eq :correction_passed
    end
  end

  describe 'validations' do

    before(:each) do
      @correction.teacher = Account.new
      @correction.solution = Solution.new
    end

    it 'should not be valid without teacher' do
      @correction.teacher = nil
      @correction.valid?.should be_false
    end

    it 'should not be valid without solution' do
      @correction.solution = nil
      @correction.valid?.should be_false
    end

    it 'should not be valid when grade 11' do
      @correction.grade = 11
      @correction.valid?.should be_false
    end
    
  end
end
