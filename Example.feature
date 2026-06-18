# Keywords in cucumber scenarios:

# Feature – High-level description of functionality or capability under test
# Scenario – Single example describing specific behaviour of the system
# Scenario Outline– As above but with multiple examples
# Given – Initial context or state before the behaviour
# When – Action or event triggering the behaviour
# Then – Expected outcome or result after the action

# Example scenario

Feature: Content is clear enough that readers keep going
  Scenario: A reader does not immediately lose the will to continue
    Given the page contains helpful and clearly written content
    When the reader scans the page
    Then the reader should understand the main point quickly
    And the reader should not sigh audibly

# Example scenario outline
Feature: The Millennium Falcon usually works when it matters most
  Scenario Outline: The Millennium Falcon successfully jumps to hyperspace
    Given the Millennium Falcon has "<hyperdrive_status>"
    And the Falcon is "<situation>"
    When Han Solo attempts the jump to hyperspace
    Then the Falcon should "<result>"

    Examples:
      | hyperdrive_status | situation                 | result                         |
      | fully operational | cruising normally         | jump smoothly                  |
      | partially damaged | under Imperial fire       | jump after a tense delay       |
      | completely broken | being chased by TIEs      | fail spectacularly             |
      | temperamental     | escaping at the last minute | work eventually, just in time  |
