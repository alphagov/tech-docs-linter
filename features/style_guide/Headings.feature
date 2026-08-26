# GitHub issue https://github.com/alphagov/tech-docs-linter/issues/30

Feature: Headings should be clear and structure the page correctly.

  Scenario Outline: A page must contain a single H1 tag
    Given the page has "<tag>" tag
    When the linter runs against the page with the "headings" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the error level should be "<error_or_blank>"
    And the message should contain "<message_or_nothing>"

    Examples:
      | tag              | number_of_messages | error_or_blank | message_or_nothing                                                |
      | a single h1      | 0                  | blank          | nothing                                                           |
      | no h1            | 1                  | error          | No H1 tag found.  Each page should contain a single H1 tag        |
      | more than one h1 | 1                  | error          | Multiple H1 tags found.  Each page should contain a single H1 tag |


  Scenario Outline: Headings in a page should not go past h3
    Given the page has a "<tag>" tag
    When the linter runs against the page with the "headings" rule
    Then the number of messages in the linter report should be 1
    And the error level should be "<error_level>"
    And the message should contain "<message>"

    Examples:
      | tag | error_level | message                                              |
      | h4  | suggestion  | consider restructuring your content to avoid h4 tags |
      | h5  | error       | you should not use headings tags greater than H4     |
      | h6  | error       | you should not use headings tags greater than H4     |

  Scenario Outline: A page should have some content between headings
    Given the page has a "<tag>" tag
    And there is "<no_content>" between them
    When the linter runs against the page with the "headings" rule
    Then the number of messages in the linter report should be 1
    And the error level should be "suggestion"
    And the message should contain "consider putting content between your headings to support screen reading technology"

    Examples:
      | tag               | no_content                        |
      | a h1 and a h2 tag | no content                        |
      | a h3 and a h3 tag | a code block with no lead in line |
      | a h2 and a h3 tag | a diagram with no lead in line    |

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
    Given there is a "<tag_1>" page section
    And this is followed by a "<tag_2>" page section
    When the linter runs against the page with the "headings" rule
    Then the error level should be "<error_or_blank>"
    And the message should contain "<message_or_nothing>"
    Examples:
      | tag_1 | tag_2 | error_or_blank | message_or_nothing                                                                               |
      # nested section
      | h2    | h3    | blank          | nothing                                                                                          |
      # new section
      | h2    | h2    | suggestion     | Page headings can help users find the information they need.  Consider splitting your content up |
      # skip a section
      | h2    | h4    | warning        | Skipping heading levels can be an accessibility issue.  Check your page structure is correct.    |

  Scenario Outline: Section headings must not end with terminal punctuation
    Given there is a heading
    And the last character in the heading is a "<terminal_punctuation_mark>"
    When the linter runs against the page with the "headings" rule
    Then the error level should be error
    And the message should contain "do not put terminal punctuations such as full stops in section headings"
    Examples:
      | terminal_punctuation_mark |
      | ?                         |
      | !                         |
      | .                         |
      | ,                         |
      | ;                         |
      | :                         |
      | -                         |

  Scenario: Section headings can contain non terminal punctuation, such as gov.uk
    Given there is a heading
    And it contains non terminal punctuation
    When the linter runs against the page with the "headings" rule
    Then the error level should be blank

  Scenario Outline: Section headings should not contain brackets
    Given there is a heading
    And the heading contains a "<bracket>"
    When the linter runs against the page with the "headings" rule
    Then the error level should be suggestion
    And the message should contain "brackets should only be used in body text for additional context"

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



#  not be longer than 65 characters (suggestion)
