Feature: Course enrollment
  As a repeater student I want to enroll myself in the new course

  Background:
    Given the course with teacher and student enrolled 
    And   '2015-01C' course was created  

  Scenario: Main flow
    And   I am logged in as student
    And   I go to the homepage
    And   I follow "aquí"
    And   I click on '2015-01C'
    And   I click "Guardar"
    Then  I am enrolled in '2015-01C'


