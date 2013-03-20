Feature: Version
  In order to check the current version
  As a user
  I should be able to run 'hw version'

  Background:
    Given pending
    Given I haven't installed Hemingway
    When I successfully run `hw update --pull=false`

  Scenario: Check an up-to-date version
    When I successfully run `hw version`
    Then the stdout should contain "Your version is up to date."

  Scenario: Check an out-of-date version
    When I successfully run `hw version`
    Then the stdout should contain "Your version is out of date."
    Then the gem should be out of date with the remote version of 10.0.0
