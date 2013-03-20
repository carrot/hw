Feature: Installation
  In order to use the CLI
  The correct directory structure must be in place

  Background:
    Given I haven't installed Hemingway
    When I successfully run `hw update`

  Scenario: Create the directory structure
    Then "~/.hw" should be created
    And "~/.hw/config" should be created
    And "~/.hw/sources/" should be created

  Scenario: Add the default package source
    Then "~/.hw/config" should contain "default=git@github.com:carrot/hw-packages.git"

  Scenario: Pull packages from git repository
    Then "~/.hw/sources/default/" should be created
    And "~/.hw/sources/default/" should be a git repository
    And "~/.hw/sources/default/" should contain packages
