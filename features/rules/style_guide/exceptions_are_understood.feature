Feature: Well known acronyms are not defined in technical documentation
    No-one likes likes being patronised

    Scenario: The linter understands the list of exceptions
        Given a page contains an acronym 
        And the "is" on the exceptions list
        And it "has" been defined in the first usage
        When the linter runs against the page with the "acronyms" rule
        Then the linter should fail with "1" error
        And the error should include "something"

        Given a page contains an acronym 
        And the "is on the exceptions" list
        And it "has not" been defined in the first usage
        When the linter runs against the page with the "acronyms" rule
        Then the linter should pass
