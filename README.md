
# Linting for technical writing
This repo contains rules based on the [GOV.UK Technical Style guide](https://www.gov.uk/guidance/style-guide/technical-content-a-to-z) and is designed to work with the linting tool Vale. You can [find more information about Vale on its website](https://vale.sh/).

## Installing the linter on your local machine
1. Install [Homebrew](https://brew.sh/).
2. Install [Vale](https://vale.sh/docs/vale-cli/installation/). 
3. Clone this repo.

## Running the linter on your local machine
To use the linter (Vale), you must provide a config file which describes where the rules for the linter are located. Vale must be run from the same directory as this config file. 

For ease of use, we provide a config file with this repo that provides the path to the rules for technical writing, however you may prefer to use your own based on any further requirements you may have and store this at the root of your repository. 

1. In a terminal window, navigate to this linter repo
2. Run the command `vale` followed by the path of the directory or file to lint, for example: `vale .`, `vale ../team-manual`, `vale ../team-manual/source/new-starter-guide/*.erb`

Errors raised by the linter will show for each file:
- the line and character number of the issue
- the severity level of the issue (error, warning, suggestion)
- a description of the issue
- the path to the rule that flagged the issue
