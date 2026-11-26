# https://insidegovuk.blog.gov.uk/2016/07/20/changes-to-the-style-guide-no-more-eg-and-ie-etc/

# https://guidance.publishing.service.gov.uk/writing-to-gov-uk-standards/style-guides/a-to-z-style-guide/#eg-etc-and-ie

#TODO:: Discuss code examples/variables

Feature: The style guide says you must not use Latin as we are not in ancient Rome

  Scenario Outline: A page contains a lower case latin abbreviation
    Given the page contains the "lower case" latin abbreviation "<abbreviation>"
    When the linter runs against the page with the "latin-abbreviations" rule
    Then the number of messages in the linter report should be 1
    And the error level should be "error"
    And the message should contain "Abbreviationes Latinae in scriptis ne adhibeantur"

    Examples:
      | abbreviation |
      | e.g |
      | e.g. |
      | eg |
      | i.e. |
      | ie |
      | etc. |
      | etc |
      | et al. |
      | et al |
      | cf. |
      | cf |
      | viz. |
      | viz |
      | vis-à-vis |
      | vis-a-vis |
      | vis a vis |
      | vs. |
      | vs |
      | v. |
      | v |
      | nb |
      | n.b |
      | n.b. |

  Scenario Outline: A page contains a lower case latin phrase
    Given the page contains the "lower case" latin phrase "<phrase>"
    When the linter runs against the page with the "latin-phrases" rule
    Then the number of messages in the linter report should be 1
    And the error level should be "error"
    And the message should contain "Locutiones Latinae in scriptis ne adhibeantur"

    Examples:
      | phrase |
      | exempli gratia |
      | id est |
      | et cetera |
      | et alia |
      | et alii |
      | confer |
      | videlicet |
      | versus |
      | nota bene |

  Scenario: A page contains an upper case latin phrase
    Given the page contains the "upper case" latin phrase "et cetera"
    When the linter runs against the page with the "latin-phrases" rule
    Then the number of messages in the linter report should be 1
    And the error level should be "error"
    And the message should contain "Locutiones Latinae in scriptis ne adhibeantur"

  Scenario: A page contains an upper case latin abbreviation
    Given the page contains the "upper case" latin abbreviation "etc"
    When the linter runs against the page with the "latin-abbreviations" rule
    Then the number of messages in the linter report should be 1
    And the error level should be "error"
    And the message should contain "Abbreviationes Latinae in scriptis ne adhibeantur"

  Scenario Outline: A page contains a normal word which has part of a latin word or phrase contained within it
    Given the page contains the latin phrase "<latin_phrase>"
    And the phrase is contained within a plain english phrase "<english_phrase>"
    When the linter runs against the page with the "latin-phrases" rule
    Then the number of messages in the linter report should be 0

    Examples:
      | latin_phrase | english_phrase |
      | id est |     intrepid establishment                 |
      | confer |     conference                 |
      | eg |     Gregg's steak bake                 |
      | vs |     remember your gloves                 |
