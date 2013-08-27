Feature: Student registration
  As a student 
  I want register
  To access my assignments

  Background:
  	Given the course "2013-1"

  Scenario: Main flow
    Given I am on the registration page
    When I fill and submit then registration form
    Then I should see "cuenta creada"
  	

