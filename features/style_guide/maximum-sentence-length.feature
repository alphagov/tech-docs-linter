# https://www.gov.uk/guidance/content-design/writing-for-gov-uk#short-sentences
# https://www.gov.uk/guidance/style-guide/a-to-z -> Sentence length

# Vale treats sentences and list items differently:
#
#  - Sentences are recognised automatically
#  - List items are just plain lines of text
# So the sentence rule never “sees” list items as separate sentences, and can’t measure them properly.
# Because of this we will handle list lengths in their own feature

Feature:  The style guide recommends sentences over 25 words should be split where possible.  If the linter finds any sentences over 25 words it should add a warning to the report.

  @passing
  Scenario Outline: A page contains content with sentences of different lengths
    Given the page has "<content>"
    When the linter runs against the page with the "sentence-length" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the error level should be "<warning_or_blank>"
    And the message should contain "<message_or_nothing>"
    Examples:
      | content                            | number_of_messages | warning_or_blank | message_or_nothing                                                                        |
      | a single long sentence             | 1                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
      | a single short sentence            | 0                  | blank            | nothing                                                                                   |
      | four short sentences               | 0                  | blank            | nothing                                                                                   |
      | four long sentences                | 4                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
      | three long and six short sentences | 3                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
    
  @passing
  Scenario Outline: A page has sentences containing or explaining acronyms
    Given the page has "<content>"
    When the linter runs against the page with the "sentence-length" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the error level should be "<warning_or_blank>"
    And the message should contain "<message_or_nothing>"
    Examples:
      | content                                         | number_of_messages | warning_or_blank | message_or_nothing                                                                        |
      | a sentence over 25 words expanding an acronym   | 1                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
      | a sentence under 26 words expanding an acronym  | 0                  | blank            | nothing                                                                                   |
      | a sentence over 25 words containing an acronym  | 1                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
      | a sentence under 26 words containing an acronym | 0                  | blank            | nothing                                                                                   |

  @passing
  Scenario Outline: A page contains characters in the middle of sentences which would normally end them, for example 'version 2.2 of WCAG'
    Given the page has "<content>"
    When the linter runs against the page with the "sentence-length" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the error level should be "<warning_or_blank>"
    And the message should contain "<message_or_nothing>"
    Examples:
      | content                              | number_of_messages | warning_or_blank | message_or_nothing                                                                        |
      #    'https://token.account.gov.uk|' covers single colon and multiple full stops.  All 4 should be ignored and count as a single word.  Also covers email addresses.
      | under 26 words with a full url       | 0                  | blank            | nothing                                                                                   |
      | over 25 words with a full url        | 1                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
      #   'version 2.2 of WCAG' should be considered 4 words.  This covers spacing around the word containing the full stop.
      | under 26 words with a version number | 0                  | blank            | nothing                                                                                   |
      | over 25 words with a version number  | 1                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
      # 'urn:fdc:gov:uk' should be one word.  Covers Uniform Resource Name (URN) used in wallet, aws etc
      | under 26 words with a URN            | 0                  | blank            | nothing                                                                                   |
      | over 25 words with a URN             | 1                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
  @passing
  Scenario Outline: A page contains inline code examples
    Given the page has "a code block inline"
    And the code block is surrounded by "<single_triple>" backticks
    And the total length of the sentence is "<sentence_length>" words
    When the linter runs against the page with the "sentence-length" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the message should contain "<message_or_nothing>"
    Examples:
      | single_triple | sentence_length | number_of_messages | message_or_nothing                                                                        |
      | single        | under 26 words  | 0                  | nothing                                                                                   |
      | single        | over 25 words   | 1                  | Check sentences with more than 25 words to see if you can split them to make them clearer |
      | triple        | under 26 words  | 0                  | nothing                                                                                   |
      | triple        | over 25 words   | 1                  | Check sentences with more than 25 words to see if you can split them to make them clearer |
  @wip
  Scenario Outline: A page contains code examples that are not inline
    Given the page has "a code block not inline"
    And the page "<does_not>" have surrounding content
    When the linter runs against the page with the "sentence-length" rule
    Then the number of messages in the linter report should be 0
    And the message should contain "<message>"
    Examples:
      | does_not |
      | does     |
      | does_not |

    # hyphens