Feature: Sometimes there are different ways to spell something.  The linter shouldn't let that happen

  Scenario: A page exists with a single commonly misspelled word
    Given a page contains "a single" misspelling
    When the linter runs against the page with the "common-misspellings" rule
    Then the linter should "fail"
    And the number of errors in the linter report should be 1
    And the error should include "The GOV.UK style guide recommends"


  Scenario: A page exists with the correct spelling of One Login
    Given a page contains "no" misspelling
    When the linter runs against the page with the "common-misspellings" rule
    Then the linter should "pass"


