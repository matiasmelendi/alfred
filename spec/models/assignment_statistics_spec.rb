require 'spec_helper'

describe AssignmentStatistics do

  let!(:assignment) { Factories::Assignment.name "TP 1" }

  subject { AssignmentStatistics.new(assignment) }

  let!(:account_1) { Factories::Account.student("aName1", "aSurname1", "a@student.com", "77788") }
  let!(:account_2) { Factories::Account.student("aName2", "aSurname2", "another1@student.com", "77789") }
  let!(:account_3) { Factories::Account.student("aName3", "aSurname3", "another2@student.com", "77790") }
  let!(:teacher) { Factories::Account.teacher }

  let!(:solution_1) { Factories::Solution::for_by assignment, account_1 }
  let!(:solution_2) { Factories::Solution::for_by assignment, account_2 }
  let!(:solution_3) { Factories::Solution::for_by assignment, account_2 }
  let!(:solution_4) { Factories::Solution::for_by assignment, account_2 }

  let!(:correction_1) { Factories::Correction.corrects_by_with_grade solution_1, teacher, 8 }
  let!(:correction_2) { Factories::Correction.corrects_by_with_grade solution_2, teacher, 3 }
  let!(:correction_3) { Factories::Correction.corrects_by_with_grade solution_3, teacher, 10 }

  describe "#corrected" do

    it "should return the corrected solutions" do
      expect(subject.send(:corrected, [solution_1, solution_2, solution_3, solution_4])).to eq [solution_1, solution_2, solution_3]
    end

    context "without solutions" do

      it "should return an empty list of corrected solutions" do
        expect(subject.send(:corrected, nil)).to eq []
      end

    end
  end

  describe "#highest_rated_solutions" do

    it "should return the solution with the highest rate" do
      expect(subject.send(:highest_rated_solution, [solution_1, solution_2])).to eq solution_1
    end

    context "without solutions" do

      it "should return nothing" do
        expect(subject.send(:highest_rated_solution, [])).to eq nil
      end

    end

  end

  describe "#clean solutions" do

    it "should return solutions excluding repeated solutions less rated and uncorrected" do
      expect(subject.send(:clean_solutions)).to eq [solution_1, solution_3]
    end

    context "without solutions" do

      before :each do
        assignment.solutions = []
      end

      it "should return an empty list of solutions" do
        expect(subject.send(:clean_solutions)).to eq []
      end

    end
  end

  describe "#solutions approved" do

    it "should return only the approved solutions" do
      expect(subject.send(:solutions_approved)).to eq [solution_1, solution_3]
    end

    context "without solutions" do

      before :each do
        assignment.solutions = []
      end

      it "should return an empty list of solutions" do
        expect(subject.send(:solutions_approved)).to eq []
      end

    end
  end

  describe "#not approved solutions" do

    let!(:solution_5) { Factories::Solution::for_by assignment, account_3 }
    let!(:correction_5) { Factories::Correction.corrects_by_with_grade solution_5, teacher, 1 }

    it "should return only the not approved solutions" do
      expect(subject.send(:not_approved_solutions)).to eq [solution_5]
    end

    context "without solutions" do

      before :each do
        assignment.solutions = []
      end

      it "should return an empty list of solutions" do
        expect(subject.send(:not_approved_solutions)).to eq []
      end

    end
  end

  describe "#corrected_solutions" do

    it "should return only the corrected solutions" do
      expect(subject.send(:corrected_solutions)).to eq [solution_1, solution_3]
    end

    context "without solutions" do

      before :each do
        assignment.solutions = []
      end

      it "should return an empty list of solutions" do
        expect(subject.send(:corrected_solutions)).to eq []
      end

    end

  end

  describe "#passed" do

    context "having approved solutions" do

      it "should return the number of solutions approved for an assignment" do
        expect(subject.passed).to be 2
      end

    end

    context "when student submit more than one solution for an assigment" do

      it "should return 2 because of it takes only one solution as valid" do
        expect(subject.passed).to be 2
      end

    end

  end

  describe "#failed" do

    let!(:solution_5) { Factories::Solution::for_by assignment, account_3 }
    let!(:correction_5) { Factories::Correction.corrects_by_with_grade solution_5, teacher, 1 }

    it " should return the not approved solutions number" do
      expect(subject.failed).to be 1
    end

  end

  describe "#total_solutions" do

    it "should return the total number of solutions" do
      expect(subject.total_solutions).to be 2
    end

    context "without solutions" do

      before :each do
        assignment.solutions = []
      end

      it "should return an empty list of solutions" do
        expect(subject.total_solutions).to eq 0
      end

    end

  end

  describe "average grades" do

    it "should return average for all solutions' grades" do
      expect(subject.general_average).to eq 9
    end

    context "no solutions" do

      before :each do
        assignment.solutions = []
      end

      it "should return 0 when there are no solutions" do
        expect(subject.general_average).to eq 0
      end

      it "should return 0 for approved solutions when there are no solutions" do
        expect(subject.approved_average).to eq 0
      end

    end

    context "with one failed solution" do

      let!(:solution_5) { Factories::Solution::for_by assignment, account_3 }
      let!(:correction_5) { Factories::Correction.corrects_by_with_grade solution_5, teacher, 2 }

      it "should return general average" do
        expect(subject.general_average).to eq 6.666666666666667
      end

      it "should return average for approved solutions" do
        expect(subject.approved_average).to eq 9
      end

    end
  end
end