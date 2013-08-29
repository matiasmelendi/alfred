Feature: Assigment creation
  As a teacher 
  I want to create assignments
  To evaluate my students

  Background:
  	Given the course "2013-1"
  	And the teacher "John"

  Scenario: Main flow
  	Given I am logged in as teacher
    Then Students menu option show be visible
    And Assignments menu option show be visible
    When I create and "as1" Assigment
    Then I should see "as1" in the assigments list
  	Then Log out menu option show be visible
  	

