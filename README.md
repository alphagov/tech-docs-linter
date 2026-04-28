
# Linting for technical writing

This package contains rules based on the [GOV.UK Technical Style guide](https://www.gov.uk/guidance/style-guide/technical-content-a-to-z) and is designed to work with the linting tool Vale. You can [find more information about Vale on its website](https://vale.sh/).

Errors raised by the linter will show for each file:

- the line and character number of the issue
- the severity level of the issue (error, warning, suggestion)
- a description of the issue
- the path to the rule that flagged the issue

If you would like to suggest a change an existing rule, such as adding an acronym to our list of exceptions, please raise this in the [#ask-di-tech-writing-architecture](https://gds.slack.com/archives/C06V5UTTJNP) Slack channel, and it will be discussed in our regular forum.

## Installing the linter on your local machine

1. Install [Homebrew](https://brew.sh/).
2. Install [Vale](https://vale.sh/docs/vale-cli/installation/).

### Adding the tech-docs-linter as a package to your config file

To use the linter (Vale), you must provide a config file which describes where the rules for the linter are located. Confirm that a `.vale.ini` exists at the root of your repo and that the url for the tech-docs-linter zip file is provided through the `Packages` field. Here is a [template](#template-vale-config) config file for reference.

## Running the linter on your local machine

By default, Vale must be run from the same directory as this config file, unless the `--config` flag is provided with a path.

1. In a terminal window, navigate to your repo
2. Run `vale sync` to download the latest tech-docs-linter package and unzip this to your `StylesPath` listed in your config file
3. Run the command `vale .` to lint the entire repo or provide a path to a directory to lint only that directory for example: `vale source/new-starter-guide/*.erb`

## Testing linting rules

The linter contains a `cucumber` test suite, found in the `/features` directory.  Tests are written in using scenario based [Behavior Driven Development (BDD)](https://www.geeksforgeeks.org/software-testing/scenario-in-cucumber-testing/).  This approach means non-technical maintainers can understand and update the behavior of the linter, with support from technical colleagues to implement `step_definitions`.

You can install cucumber using `bundle install` or `gem install cucumber`.  For more details see [the documentation](https://cucumber.io/docs/installation/ruby/).

To run the full cucumber suite you can run the following command:

`bundle exec cucumber`

To run a single file add the filepath to the feature, for example:

`bundle exec cucumber features/style_guide/misspellings.feature`

To run a single scenario in a feature file, add the line number.  For example:

`bundle exec cucumber features/rules/style_guide/acronyms.feature:29`


## Releasing an update to the linter

Before releasing a new package you should:

- make sure the CHANGELOG has been updated
- add a new feature file to the [cucumber test suite](#testing-linting-rules) and define the rule
- ensure all the tests pass

To release an update:

- change directory to the styles folder
- create a zip package of the tech-writing-style-guide folder: `zip -r tech-writing-style-guide.zip tech-writing-style-guide`
- select **Draft a new release** from the [releases page for the linter](https://github.com/alphagov/tech-docs-linter/releases)
- upversion the tag and add information about the changes that have been made
- upload the tech-writing-style-guide package

## Additional Resources

### Template Vale config

``` yaml
StylesPath = vale-styles 
Packages = https://github.com/alphagov/tech-docs-linter/releases/latest/download/tech-writing-style-guide.zip

# Local Config
[formats]
erb=md
MinAlertLevel = error
[*.{md,org,txt,erb,html}]
TokenIgnores = (\*{2}(.+)\*{2})

BasedOnStyles = tech-writing-style-guide
```
