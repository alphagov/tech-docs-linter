#https://guidance.publishing.service.gov.uk/writing-to-gov-uk-standards/style-guides/a-to-z-style-guide/
#https://guidance.publishing.service.gov.uk/writing-to-gov-uk-standards/style-guides/technical-a-to-z/
Feature: The GOV.UK Style and Technical Style guides contain a list of "words to avoid" which should not be used in our content.  Some of these are strict, some are situation-dependent.  If the linter finds these words in some content, it should highlight the words and give the advice or suggestion found in the style guide.

  Scenario Outline: A page exists containing content matching the words to avoid
    Given a page contains content from the "<govuk_technical>" style guide words to avoid
    And the style guide rule "<has_has_not>" got exceptions
    When the linter runs against the page with the "<linter_rule>" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the error level should be "<error_level>"
    And the message should contain "<message>"

    Examples:
      | govuk_technical | has_has_not | linter_rule           | number_of_messages | error_level | message                           |
      | govuk           | has         | words-to-avoid-unless | 3                  | warning     | The style guide suggests:         |
      | govuk           | has not     | words-to-avoid        | 1                  | error       | From style guide words to avoid: |
      | technical       | has not     | words-to-avoid        | 1                  | error       | From style guide words to avoid: |
      | technical       | has         | words-to-avoid-unless | 3                  | warning     | The style guide suggests:         |

