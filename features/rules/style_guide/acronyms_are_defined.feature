Feature: Acronyms are defined in technical documentation
    No-one likes likes to not know what an acronym means

    Scenario: The linter can check for acronym definitions
        Given a page contains an acronym 
        And the acronym "is not" on the exceptions list
        And it "has not" been defined in the first usage
        When the linter runs against the page with the "acronyms" rule
        Then the linter should fail with 1 error
        And the error should include "must be defined in the first instance"

        Given a page contains an acronym 
        And the acronym "is not" on the exceptions list
        And it "has" been defined in the first usage
        Then the linter should pass