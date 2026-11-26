# https://insidegovuk.blog.gov.uk/2016/07/20/changes-to-the-style-guide-no-more-eg-and-ie-etc/
# https://guidance.publishing.service.gov.uk/writing-to-gov-uk-standards/style-guides/a-to-z-style-guide/#eg-etc-and-ie
#TODO:: Discuss code examples/variables

"""

This table gives the abbreviations and corresponding phrases (and their meanings, for interested parties) that the latin rule will highlight as not allowed.

| abbreviation                                  | Phrase                   | Meaning                                                                                                                   |
|-----------------------------------------------|--------------------------|---------------------------------------------------------------------------------------------------------------------------|
| e.g / e.g. /        eg                        | exempli gratia           | Means "for example." Use it to introduce a non-exhaustive list of examples.                                               |
| i.e. /   ie / i.e                             | id est                   | Means "that is" or "in other words." Use it to clarify, rephrase, or specify something just mentioned.                    |
| etc. / etc                                    | et cetera                | Means "and so forth" or "and other things of the same kind."                                                              |
| et al. / et al                                | et alia /   et alii      | Means "and others." Commonly used to shorten author lists in academic citations (e.g., Smith et al.).                     |
| cf.  / cf                                     | confer                   | Means "compare." Used to point a reader toward a contrasting or comparative source.                                       |
| viz. / viz                                    | videlicet                | Means "namely" or "that is to say." Used to introduce a complete, exhaustive list or specification.                       |
| n/a (not really Latin, but in a similar vein) | vis-à-vis /    vis a vis | French (with Latin roots) and literally means "face-to-face". Used in English to mean "in relation to" or "compared with" |
| vs. / vs /  v. / v                            | versus                   | Means "against." Used in legal case names or competitive matchups.                                                        |
| nb / n.b / n.b.                               | nota bene                | Means "take careful note" or "note well." Used to draw attention to an important point.                                   |

"""

Feature: The style guide says you must not use Latin as we are not in ancient Rome

  Scenario Outline: A page exists containing content matching the latin abbreviations to avoid
    Given a page contains content from the latin "<abbreviations_phrases>" to avoid
    And the content is in "<upper_lower>" case
    And the content "<does_not>" contain punctuation
    And the content "is not part" of an English word or phrase
    When the linter runs against the page with the "<linter_rule>" rule
    Then the number of messages in the linter report should be <number_of_messages>
    And the error level should be "<error_level>"
    And the message should contain "<message>"
    Examples:
      | abbreviations_phrases | upper_lower | does_not | linter_rule        | number_of_messages | error_level | message                                           |
      | abbreviation          | lower       | does not | latin-abbreviation | 1                  | error       | Abbreviationes Latinae in scriptis ne adhibeantur |
      | abbreviation          | lower       | does     | latin-abbreviation | 1                  | error       | Abbreviationes Latinae in scriptis ne adhibeantur |
      | abbreviation          | upper       | does not | latin-abbreviation | 1                  | error       | Abbreviationes Latinae in scriptis ne adhibeantur |
      | abbreviation          | upper       | does     | latin-abbreviation | 1                  | error       | Abbreviationes Latinae in scriptis ne adhibeantur |
      | phrase                | lower       | does not | latin-phrase       | 1                  | error       | Locutiones Latinae in scriptis ne adhibeantur     |
      | phrase                | lower       | does     | latin-phrase       | 1                  | error       | Locutiones Latinae in scriptis ne adhibeantur     |
      | phrase                | upper       | does not | latin-phrase       | 1                  | error       | Locutiones Latinae in scriptis ne adhibeantur     |
      | phrase                | upper       | does     | latin-phrase       | 1                  | error       | Locutiones Latinae in scriptis ne adhibeantur     |

  Scenario Outline: A page contains an English word or phrase containing content matching the latin abbreviations to avoid
    Given a page contains content from the latin "<abbreviations_phrases>" to avoid
    And the content is in "<upper_lower>" case
#    And the content "<does_not>" contain punctuation
    And the content "is part" of an English word or phrase
    When the linter runs against the page with the "<linter_rule>" rule
    Then the number of messages in the linter report should be 0
    Examples:
      | abbreviations_phrases | upper_lower | linter_rule  |
      | phrase                | upper       | latin-phrase |
      | phrase                | lower       | latin-phrase |

#    Examples:
#      | latin_phrase | english_phrase         |
#      | id est       | intrepid establishment |
#      | confer       | conference             |
#      | eg           | Gregg's steak bake     |
#      | vs           | remember your gloves   |
#  so far no examples come to mind of abbreviations with punctuation, but possibly in code blocks that give object notation e.g. user.eg.somethign?
#  Seems tenuous though
