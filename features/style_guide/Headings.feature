# GitHub issue https://github.com/alphagov/tech-docs-linter/issues/30

Feature: Headings should be clear and structure the page correctly.
#agree messages when we write the rule
# depending on how rules can be implemented we might need to split out different rules

  Scenario Outline: A page must contain a single H1 tag
    Given the page has "<tag>" tag
    When the linter runs against the page with the "headings" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the error level should be "<error_or_blank>"
    And the message should contain "<message_or_nothing>"

    Examples:
      | tag              | number_of_messages | error_or_blank | message_or_nothing                    |
      | a single h1      | 0                  | blank          | nothing                               |
      | no h1            | 1                  | error          | something to say the h1 is missing    |
      | more than one h1 | 1                  | error          | something to say the h1 is duplicated |


  Scenario Outline: Headings in a page should not go past h3
    Given the page has a "<tag>" tag
    When the linter runs against the page with the "headings" rule
    Then the number of messages in the linter report should be 1
    And the error level should be "<error_level>"
    And the message should contain "<message>"

    Examples:
      | tag | error_level | message            |
      | h4  | suggestion  | maybe have a think |
      | h5  | error       | do not use         |
      | h6  | error       | do not use         |

  Scenario Outline: A page should have some content between headings
    Given the page has a "<tag>" tag
    And there is "<no_content>" between them
    When the linter runs against the page with the "headings" rule
    Then the number of messages in the linter report should be 1
    And the error level should be "suggestion"
    And the message should contain "<consider putting content between your headings to support screen reading technology>"

    Examples:
      | tag               | no_content                        |
      | a h1 and a h2 tag | no content                        |
      | a h3 and a h3 tag | a code block with no lead in line |
      | a h2 and a h3 tag | a diagram with no lead in line    |

# from the github issue linked above:
# ... [headings] should not:
#  contain punctuation except non ending such as gov.uk (error)
#  contain acronyms or abbreviations except those on the commonly known list (warning)
#  not be longer than 65 characters (suggestion)

# potential extra scenarios:
#  checking page structure - eg  H2 should not come before  H1, H3 not before H2 etc
