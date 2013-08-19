require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "RegistrationAndLogin" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = ENV['base_url']
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_registration_and_login" do
    @driver.get(@base_url + "/login")
    @driver.find_element(:link, "crear cuenta").click
    @driver.find_element(:id, "account_name").send_keys "juan"
    @driver.find_element(:id, "account_surname").send_keys "perez"
    @driver.find_element(:id, "account_buid").send_keys "78555"
    @driver.find_element(:id, "account_email").send_keys "juan.perez@test.com"
    @driver.find_element(:id, "account_tag").send_keys "mie"
    @driver.find_element(:id, "account_password").send_keys "Passw0rd!"
    @driver.find_element(:id, "account_password_confirmation").send_keys "Passw0rd!"
    @driver.find_element(:css, "input.btn.btn-primary").click
    element_present?(:xpath, "//body[@id='top']/div[2]/div/div").should be_true
    @driver.find_element(:name, "email").send_keys "juan.perez@test.com"
    @driver.find_element(:name, "password").send_keys "Passw0rd!"
    @driver.find_element(:id, "sign_in").click
    element_present?(:link, "juan.perez@test.com").should be_true
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
