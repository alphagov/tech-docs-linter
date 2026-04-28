Feature: Acronyms are defined in technical documentation
    No-one likes likes to not know what "an acronym" means

    Scenario: A page has been created with a single unknown acronym that has not been defined in full
        Given a page contains "a single uncommon undefined" acronym
        When the linter runs against the page with the "acronyms" rule
        Then the linter should "fail"
        And the number of errors in the linter report should be 1
        And the error should include "must be defined in the first instance"

    Scenario: A page has been created with a single unknown acronym that has been defined in full
        Given a page contains "a single uncommon defined" acronym
        When the linter runs against the page with the "acronyms" rule
        Then the linter should "pass"

    Scenario: A page has been created with a widley known acronym that has been defined in full
        Given a page contains "a single common defined" acronym
        When the linter runs against the page with the "acronyms" rule
        Then the linter should "pass"

    Scenario: A page has been created with a widley known acronym, and not defined unnecessarily
        Given a page contains "a single common undefined" acronym
        When the linter runs against the page with the "acronyms" rule
        Then the linter should "pass"

#add scenarios for multiple things on a page, some defined some not
