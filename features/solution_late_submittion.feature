Feature: Allowing late submissions

  Background:
    Given the course with teacher and student enrolled
    And I am logged in as teacher
    And I follow "Trabajos prácticos"
    And I follow "Nuevo"
    And I fill data for blocking assignment "TP0" due to "22/06/2015" to be delivered as "link"
    And I am logged in as student
@wip
  Scenario: Not submitting a solution
    When due date for "TP0" passes
    And I follow "Trabajos prácticos"
    Then student can submit a solution for "TP0"
@wip
  Scenario: Submitting a solution on time
    Given I follow "Trabajos prácticos"
    And  I click submit solution for "TP0"
    And  I fill in link to solution
    And I click save button
    When due date for "TP0" passes
    Then student cannot submit a solution again for "TP0"
