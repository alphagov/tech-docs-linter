
# Linting for technical writing
This package contains rules based on the [GOV.UK Technical Style guide](https://www.gov.uk/guidance/style-guide/technical-content-a-to-z) and is designed to work with the linting tool Vale. You can [find more information about Vale on its website](https://vale.sh/).

Errors raised by the linter will show for each file:
- the line and character number of the issue
- the severity level of the issue (error, warning, suggestion)
- a description of the issue
- the path to the rule that flagged the issue

## Installing the linter on your local machine
1. Install [Homebrew](https://brew.sh/).
2. Install [Vale](https://vale.sh/docs/vale-cli/installation/). 

### Adding the tech-docs-linter as a package to your config file
To use the linter (Vale), you must provide a config file which describes where the rules for the linter are located. Confirm that a `.vale.ini` exists at the root of your repo and that the url for the tech-docs-linter zip file is provided through the `Packages` field. Here is a [template](#template-vale-config) config file for reference.

## Running the linter on your local machine
By default, Vale must be run from the same directory as this config file, unless the `--config` flag is provide with a path. 
1. In a terminal window, navigate to your repo
2. Run `vale sync` to download the latest tech-docs-linter package and unzip this to your `StylesPath` listed in your config file
3. Run the command `vale .` to lint the entire repo or provide a path to a directory to lint only that directory for example: `vale source/new-starter-guide/*.erb`

## Additional Resources 
### Template Vale config
```
StylesPath = vale-styles 
Packages = https://github.com/alphagov/tech-docs-linter/releases/latest/download/tech-writing-style-guide.zip

# Local Config
MinAlertLevel = error
[*.{md,org,txt,erb,html}]

BasedOnStyles = tech-writing-style-guide
```