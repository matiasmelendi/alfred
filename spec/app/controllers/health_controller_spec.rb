require 'spec_helper'

describe "HealthController" do

	it "index should return Account.count " do
		Account.should_receive(:count).and_return(1)		
	  get "/health"
	  last_response.status.should == 200
    last_response.headers['Content-Type'].should eq 'application/json;charset=utf-8'
    last_response.body.include?("{\"account_count\":1}").should be_true
	end

end
