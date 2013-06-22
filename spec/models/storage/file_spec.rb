require 'spec_helper'

describe Storage::File do
	class RemixTest
		include DataMapper::Resource

		remix 1, 'Storage::File', :as => 'file'
	end

	it "should allow to set name" do
	  file = RemixTestFile.new
	  
	  file.name = 'myfile'
	  file.name.should == 'myfile'
	end

	it "should return nil on name if path is not set" do
	  file = RemixTestFile.new
		
		file.path.should be_nil
		file.name.should be_nil
	end

	it "should not raise error if nil is attempted to be assigned to name" do
	  file = RemixTestFile.new

	  expect { file.name = nil }.not_to raise_error
	end

	# Validations are not working, need to look into this...
	xit "should validate presence of path" do
	  file = RemixTestFile.new

		file.path.should be_nil
		file.valid?.should be_false
		file.save.should be_false
	end

	it "should set definitive path on save" do
	  file = RemixTestFile.new 
debugger	  
	  file.name = 'myFile'

	  file.path.should == "/assignments/temp/myfile"

	  file.assignment = assignment

	  file.save

	  file.path.should == "/assignments/#{assignment.id}/myfile"
	end

	it "should validate unique path" do
		file1 = RemixTestFile.new()
		file1.name = 'myFile'
		file1.save

		file2 = RemixTestFile.new()
		file2.name = 'myFile'

		file2.valid?.should be_false
		file2.save.should be_false
	end

	it "unique path validation should be case insensitive" do
	  file1 = RemixTestFile.new()
		file1.name = 'myFile'
		file1.save

		file2 = RemixTestFile.new()
		file2.name = 'MYFILE'

		file2.valid?.should be_false
		file2.save.should be_false
	end

	it "should not allow to change the name after set" do
	  file = RemixTestFile.new()
		file.name = 'myFile'

		expect { file.name = 'anotherFile' }.to raise_error(Storage::CannotUpdateNameError)
	end

	it "should not raise error if path is set twice with same value" do
	  file = RemixTestFile.new()
		file.name = 'myFile'

		expect { file.name = 'MYFILE' }.not_to raise_error(Storage::CannotUpdateNameError)
	end
end
