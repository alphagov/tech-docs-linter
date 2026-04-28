Feature: Acronyms are defined in technical documentation
    No-one likes likes to not know what "an acronym" means

    Scenario: A page has been created with a single unknown acronym that has not been defined in full
        Given a page contains "an acronym"
        And the acronym "is not" considered well known
        And it "has not" been defined in the first instance
        When the linter runs against the page with the "acronyms" rule
        Then the linter should "fail"
        And the number of errors in the linter report should be 1
        And the error should include "must be defined in the first instance"

    Scenario: A page has been created with a single unknown acronym that has been defined in full
        Given a page contains "an acronym"
        And the acronym "is not" considered well known
        And it "has" been defined in the first instance
        When the linter runs against the page with the "acronyms" rule
        Then the linter should "pass"

    Scenario: A page has been created with a widley known acronym that has been defined in full
        Given a page contains "an acronym"
        And the acronym "is" considered well known
        And it "has" been defined in the first instance
        When the linter runs against the page with the "acronyms" rule
        Then the linter should "pass"
#        should this rule be a failure so we enforce consistency
#        Then the linter should "pass"
#        And the number of errors in the linter report should be 1
#        And the error should include "something"

    Scenario: A page has been created with a widley known acronym, and not defined unnecessarily
        Given a page contains "an acronym"
        And the acronym "is" considered well known
        And it "has not" been defined in the first instance
        When the linter runs against the page with the "acronyms" rule
        Then the linter should "pass"
