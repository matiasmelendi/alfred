require 'spec_helper'

describe Correction do

  let(:assignment) { Factories::Assignment.vending_machine }
	let(:teacher) { Factories::Account.teacher }
	let(:solution) { Factories::Solution.for(assignment) }
  let(:student) { solution.account }

	before (:each) do
    @correction = Correction.new(
      :teacher => teacher,
      :solution => solution,
      :public_comments => "public comment",
      :private_comments => "private comment",
      :grade => 10
    )
	end

	subject { @correction }

	it { should respond_to( :solution ) }
	it { should respond_to( :teacher ) }
	it { should respond_to( :public_comments ) }
	it { should respond_to( :private_comments ) }
	it { should respond_to( :grade ) }


  describe "creation" do
      before do
        @correction = Correction.new(
          :teacher => Factories::Account.teacher( "Yoda", "yoda@d.com"),
          :solution => solution,
          :public_comments => "public comment",
          :private_comments => "private comment",
          :grade => 9
        )
        @correction.save
      end

      it "should have creating date equal to today" do
        @correction.created_at.to_date.should == Date.today
      end
  end

  describe "invalid" do

    describe "duplicated correction" do
      before do
        @correction.save
        @duplicated_correction = Correction.new(
          :teacher => Factories::Account.teacher( "Yoda", "yoda@d.com"),
          :solution => solution,
          :public_comments => "public comment",
          :private_comments => "private comment",
          :grade => 9
        )
      end
      it "should not be both corrections with the same teacher and solution" do
        @duplicated_correction.should_not be_valid
      end
    end

    describe "not valid without teacher" do
      before  { @correction.teacher = Factories::Account.student }
      it      { should_not be_valid }
    end

    describe "not valid with a grade out of range" do
      it "should not be valid with a grade of 11" do
        @correction.grade = 11
        @correction.should_not be_valid
      end

      it "should not be valid with a grade of -1" do
        @correction.grade = -1
        @correction.should_not be_valid
      end
    end

    describe "not valid without solution" do
      before  { @correction.solution = nil }
      it      { should_not be_valid }
    end

    describe "not valid without teacher" do
      before  { @correction.teacher = nil }
      it      { @correction.should_not be_valid }
    end
  end

  describe "valid" do
    it { should be_valid }

		it "should have the right teacher and solution" do
			@correction.teacher.should == teacher
			@correction.solution.should == solution
		end

    describe "without grade" do
      it "should save a correction with nil grade" do
        @correction.grade = nil
        @correction.should be_valid
      end
    end

    describe "not duplicated correction" do
      before do
        @correction.save
        other_solution = Factories::Solution.for_by( assignment,
          Factories::Account.student("Luck", "luck@d.com") )
        @another_correction = Correction.new(
          :teacher => teacher,
          :solution => other_solution,
          :public_comments => "public comment",
          :private_comments => "private comment",
          :grade => 9
        )
      end

      it "should be allowed corrections with different teacher and solution" do
        @another_correction.should be_valid
      end
    end

  end

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

  describe "support longer comments" do
    let(:comment_length) { 512 }  # Twice string property max length
    it "should support public comment longer than 255 characters" do
      @correction.public_comments = " " * comment_length
      @correction.save.should == true
    end

    it "should support private comment longer than 255 characters" do
      @correction.private_comments = " " * comment_length
      @correction.save.should == true
    end


  end
end
