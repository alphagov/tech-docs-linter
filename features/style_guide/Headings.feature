# GitHub issue https://github.com/alphagov/tech-docs-linter/issues/30

Feature: Headings should be clear and structure the page correctly.

  Scenario Outline: A page must contain a single H1 tag
    Given the page has "<tag>" tag
    When the linter runs against the page with the "multiple-h1-tags" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the error level should be "<error_or_blank>"
    And the message should contain "<message_or_nothing>"

    # Middleman will not build a page without at last 1 H1 tag, so we don't need to lint this, and could not build an example to test against anyway.

    Examples:
      | tag              | number_of_messages | error_or_blank | message_or_nothing     |
      | a single h1      | 0                  | blank          | nothing                |
   #   | no h1            | 1                  | error          | No H1 tag found.  Each page should contain a single H1 tag        |
      | more than one h1 | 1                  | error          | Multiple H1 tags found |


  Scenario Outline: Headings in a page should not go past h3
    Given the page has "<tag>" tag
    When the linter runs against the page with the "<rule>" rule
    Then the number of messages in the linter report should be 1
    And the error level should be "<error_level>"
    And the message should contain "<message>"

    Examples:
      | tag   | rule | error_level | message                              |
      | an h4 | H4   | suggestion  | avoid H4 tags                        |
      | an h5 | H5   | error       | not use heading tags greater than H4 |
      | an h6 | H5   | error       | not use heading tags greater than H4 |

  Scenario Outline: A page should have some content between headings
    Given the page has "<tag>" tag
    And there is "<no_content>" between them
    When the linter runs against the page with the "headings-with-no-content" rule
    Then the number of messages in the linter report should be 1
    And the error level should be "suggestion"
    And the message should contain "content between your headings to support screen reading"

    Examples:
      | tag               | no_content                        |
      | a h1 and a h2 tag | no content                        |
      | a h2 and a h2 tag | a table with no lead in line      |
      | a h2 and a h3 tag | a diagram with no lead in line    |
      | a h3 and a h3 tag | a code block with no lead in line |


#  The linter can not properly understand the context of sections and sub-sections,for example:
#
#    ## Section two
#      lorem ipsum....
#    ### a nice subheading
#      ... ipsum lorem
#  ## whoops this should be a sub heading not a new section
#  ... this isn't invalid structure, it's contextually incorrect.  This is where you need a human (i.e. a Tech Writer)
#  The linter can check we haven't skipped headings though, freeing up your Tech Writer to help with the more subtle changes

  Scenario Outline: Section headings should follow incrementally
    Given heading tag "<tag_1>" is followed by heading tag "<tag_2>"
    When the linter runs against the page with the "<rule>" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the error level should be "<error_or_blank>"
    And the message should contain "<message_or_nothing>"
    Examples:
      | tag_1 | tag_2 | rule                   | number_of_messages | error_or_blank | message_or_nothing                                                          |
      # nested section
      | h2    | h3    | consecutive-headings   | 0                  | blank          | nothing                                                                     |
      | h2    | h3    | skipped-heading-levels | 0                  | blank          | nothing                                                                     |
      # new section
      | h2    | h2    | consecutive-headings   | 1                  | suggestion     | headings can help users find the information they need. Consider splitting |
      # skip a section
      | h2    | h4    | skipped-heading-levels | 1                  | warning        | can be an accessibility issue. Check your page structure                   |

  Scenario Outline: Section headings must not end with terminal punctuation
    Given the heading contains "no punctuation" and the last character in the heading is "<terminal_punctuation_mark>"
    When the linter runs against the page with the "terminal-punctuation" rule
    Then the number of messages in the linter report should be 1
    And the error level should be "error"
    And the message should contain "not end section headings with terminal punctuations"
    Examples:
      | terminal_punctuation_mark |
      | ?                         |
      | !                         |
      | .                         |
      | ,                         |
      | ;                         |
      | :                         |
      | -                         |

  Scenario Outline: Section headings can contain non terminal punctuation, such as gov.uk
    Given the heading contains "<string>" and the last character in the heading is "test"
    When the linter runs against the page with the "terminal-punctuation" rule
    Then the number of messages in the linter report should be 0
    Examples:
      | string |
      |gov.uk  |
      |urn:test:aws |
      |hyphen-ation |

  Scenario Outline: Section headings should not contain brackets
    Given the heading contains "<bracket>" and the last character in the heading is "test"
    When the linter runs against the page with the "brackets-in-headings" rule
    Then the number of messages in the linter report should be 1
    And the error level should be "error"
    And the message should contain "Brackets should only be used in body text"

    Examples:
      | bracket |
      | [       |
      | ]       |
      | (       |
      | )       |
      | {       |
      | }       |
      | >       |
      | <       |

Scenario: Headings should not contain more than 65 characters
  Given the page has "a quite long header" tag
  When the linter runs against the page with the "headings-length" rule
  Then the number of messages in the linter report should be 2
  And the error level should be "warning"