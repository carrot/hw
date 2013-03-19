Feature: Version
  In order to check the current version
  As a user
  I should be able to run 'hw version'

  Background:
    Given I haven't installed Hemingway before
    When I successfully run `hw update --pull=false`

  Scenario: Check an up-to-date version
    Given pending
    When I successfully run `hw version`
    Then the stdout should contain "Your version is out of date."

  Scenario: Check an out-of-date version
    When I successfully run `hw version`
    Then the stdout should contain "Your version is up to date."


