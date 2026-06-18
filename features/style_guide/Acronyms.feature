Feature: Acronyms that are not on the exceptions list need to be defined in full the first time they are used.  If the linter finds any that fail this rule they should be added to the final output report

  Scenario: A page has been created with a single unknown acronym that has not been defined in full
    Given a page contains "a single uncommon undefined" acronym
    When the linter runs against the page with the "acronyms" rule
    Then the number of messages in the linter report should be 1
    And the error level should be "error"
    And the message should contain "must be defined in the first instance"

  Scenario: A page has been created with a single unknown acronym that has been defined in full
    Given a page contains "a single uncommon defined" acronym
    When the linter runs against the page with the "acronyms" rule
    Then the number of messages in the linter report should be 0

  Scenario: A page has been created with a widley known acronym that has been defined in full
    Given a page contains "a single common defined" acronym
    When the linter runs against the page with the "acronyms" rule
    Then the number of messages in the linter report should be 0

  Scenario: A page has been created with a widley known acronym, and not defined unnecessarily
    Given a page contains "a single common undefined" acronym
    When the linter runs against the page with the "acronyms" rule
    Then the number of messages in the linter report should be 0

  Scenario Outline: A page has been created with lots of new acronyms
    Given a page contains "<types_of_acronyms>" acronyms
    And "<how_many_of_the_acronyms>" of the acronyms have been defined
    When the linter runs against the page with the "acronyms" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the message should contain "<message_or_nothing>"

    Examples:
      | types_of_acronyms   | how_many_of_the_acronyms | number_of_messages |message_or_nothing |
      | multiple uncommon   | all                | 0                  |nothing            |
      | multiple uncommon   | none defined       | 3                  |must be defined in the first instance |
      | multiple common     | none defined       | 0                  |nothing |
      | 3 common 3 uncommon | none defined       | 3                  |must be defined in the first instance |
      | 3 common 4 uncommon | half defined       | 2                  |must be defined in the first instance |
