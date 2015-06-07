Feature: Allowing late submissions

  Background:
    Given the course with teacher and student enrolled
    And there is a bunch of assignment already created
    Given there is a blocking assignment "TP0" with due date "22/06/2015" already created
    And I am logged in as student
@wip
  Scenario: Submitting a solution on time
    Given I follow "Trabajos prácticos"
    And  I click submit solution for "TP0"
    And  I upload the solution's file for "TP0"
    When due date for "TP0" passes
    Then student cannot submit a solution again for "TP0"
@wip
  Scenario: Not submitting a solution
    When due date for "TP0" passes
    And I follow "Trabajos prácticos"
    Then student can submit a solution for "TP0"
