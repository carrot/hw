Feature: Adding Sources
  Enable the user to append custom sources.

  Background:
    Given I haven't installed Hemingway before
    When I successfully run `hw update`

  Scenario: Add a custom git source
    When I successfully run `hw add_source private git@github.com:carrot/hw-packages-private.git`
    Then "~/.hw/config" should contain "private=git@github.com:carrot/hw-packages-private.git"

  Scenario: Add a custom local source
    When I successfully run `hw add_source local /tmp/test/`
    Then "~/.hw/config" should contain "local=/tmp/test/"
