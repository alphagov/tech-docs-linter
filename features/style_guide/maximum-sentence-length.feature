# https://www.gov.uk/guidance/content-design/writing-for-gov-uk#short-sentences
# https://www.gov.uk/guidance/style-guide/a-to-z -> Sentence length
Feature:  The style guide recommends sentences over 25 words should be split where possible.  If the linter finds any sentences over 25 words it should add a warning to the report.

  Scenario Outline: A page contains content with sentences of different lengths
    Given the page has "<content>"
    When the linter runs against the page with the "max sentence" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the error level should be "<warning_or_blank>"
    And the message should contain "<message_or_nothing>"
    Examples:
      | content                            | number_of_messages | warning_or_blank | message_or_nothing                                                                        |
      | no content                         | 0                  | nothing          | nothing                                                                                   |
      | a single long sentence             | 1                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
      | a single short sentence            | 0                  | nothing          | nothing                                                                                   |
      | four short sentences               | 0                  | nothing          | nothing                                                                                   |
      | four long sentences                | 4                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
      | three long and six short sentences | 3                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |

  Scenario Outline: A page contains lists with lead in line and item sentences of different lengths
    Given the page has "<content>"
    And the number of items in the list is 3
    And the number of long lead in lines is <long_lead_in_lines>
    And the number of long list items is <long_list_items>
    When the linter runs against the page with the "max sentence" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the error level should be "<warning_or_blank>"
    And the message should contain "<message_or_nothing>"
    Examples:
      | content   | long_lead_in_lines | long_list_items | number_of_messages | warning_or_blank | message_or_nothing                                                                        |
      | one list  | 0                  | 0               | 0                  | blank            | nothing                                                                                   |
      | one list  | 1                  | 0               | 1                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
      | one list  | 0                  | 1               | 1                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
      | two lists | 0                  | 0               | 0                  | blank            | nothing                                                                                   |
      | two lists | 2                  | 0               | 2                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
      | two lists | 0                  | 2               | 2                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |
      | two lists | 1                  | 1               | 2                  | warning          | Check sentences with more than 25 words to see if you can split them to make them clearer |

  Scenario Outline: A page has sentences containing or explaining acronyms
    Given the page has "<content>"
    And the total length of the sentence is "<sentence_length>" words
    When the linter runs against the page with the "max sentence" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the error level should be "warning"
    And the message should contain "Check sentences with more than 25 words to see if you can split them to make them clearer"
    Examples:
      | content                          | sentence_length | number_of_messages |
      | a sentence expanding an acronym  | over 25 words   | 1                  |
      | a sentence expanding an acronym  | under 26 words  | 0                  |
      | a sentence containing an acronym | over 25 words   | 1                  |
      | a sentence containing an acronym | under 26 words  | 0                  |

  Scenario Outline: A page contains characters in the middle of sentences which would normally end them, for example 'version 2.2 of WCAG'
    Given the page has "<content>"
    And the total length of the sentence is "<sentence_length>" words
    When the linter runs against the page with the "max sentence" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the message should contain "<message_or_nothing>"
    Examples:
      | content          | sentence_length | number_of_messages | message_or_nothing                                                                        |
      #    'https://token.account.gov.uk|' covers single colon and multiple full stops.  All 4 should be ignored and count as a single word.  Also covers email addresses.
      | a full url       | under 26 words  | 0                  | nothing                                                                                   |
      | a full url       | over 25 words   | 1                  | Check sentences with more than 25 words to see if you can split them to make them clearer |
      #   'version 2.2 of WCAG' should be considered 4 words.  This covers spacing around the word containing the full stop.
      | a version number | under 26 words  | 0                  | nothing                                                                                   |
      | a version number | over 25 words   | 1                  | Check sentences with more than 25 words to see if you can split them to make them clearer |
      # 'urn:fdc:gov:uk' should be one word.  Covers Uniform Resource Name (URN) used in wallet, aws etc
      | a URN            | under 26 words  | 0                  | nothing                                                                                   |
      | a URN            | over 25 words   | 1                  | Check sentences with more than 25 words to see if you can split them to make them clearer |

  Scenario Outline: A page contains inline code examples
    Given the page has "a code block"
    And the code block is "inline"
    And the code block is surrounded by "<single_triple>" backticks
    And the total length of the sentence is "<sentence_length>" words
    When the linter runs against the page with the "max sentence" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the message should contain "<message_or_nothing>"
    Examples:
      | single_triple | sentence_length | number_of_messages | message_or_nothing                                                                        |
      | single        | under 26 words  | 0                  | nothing                                                                                   |
      | single        | over 25 words   | 1                  | Check sentences with more than 25 words to see if you can split them to make them clearer |
      | triple        | under 26 words  | 0                  | nothing                                                                                   |
      | triple        | over 25 words   | 1                  | Check sentences with more than 25 words to see if you can split them to make them clearer |

  Scenario Outline: A page contains code examples that are not inline
    Given the page has "a code block"
    And the code block is "not inline"
    And the page "<does_not>" have surrounding content
    When the linter runs against the page with the "max sentence" rule
    Then the number of messages in the linter report should be 0
    And the message should contain "<message>"
    Examples:
      | does_not |
      | does     |
      | does_not |