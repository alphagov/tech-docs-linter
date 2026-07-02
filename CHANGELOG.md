# Changelog

## v0.5.1.1

- Make warning message for 'commit' more consistent

## v0.5.1

- Update words to avoid rule to move 'commit' to "words to avoid unless"
- Add exceptions to acronyms list
- bump `govuk_tech_docs` to `6.3.0`

## v0.5.0

- added new rule for words to avoid
- bump `govuk_tech_docs` to `6.2.4`
- add an example [Rakefile with formatted output](Rakefile.example)

## v0.4.1

## new features

- added new rule for maximum sentence length
- added behavioural tests for all existing rules

## v0.3.0

### New features

- Extend the regex for acronym checks to exclude capitalised 3-5 letter words that are included either as part of URLs or in a style that matches Jira tickets. Reduction of false positives.

## v0.2.0

### New features

- Add rule to enforce that acronyms are defined on first use. GDS technical writers have agreed an initial list of exceptions

## v0.1.0

### New features

- Begin versioning for updates to this repo
- Existing rule set has been replaced with a single well-agreed rule, so that errors are not raised when the linter is added to a new reposistory
- Rule upholds branding standards for product
