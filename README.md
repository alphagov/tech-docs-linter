
# Linting tool prototype
This repo contains a linting tool prototype to run tests against documentation. It uses a tool called Vale with some customised rules. You can [find more information about Vale on its website](https://vale.sh/).  

## Before you use the linting tool

1. Install [Homebrew](https://brew.sh/).
2. Install [Vale](https://vale.sh/docs/vale-cli/installation/). 
3. Clone this repo.

## Put your documentation in the `source` folder
The linting tool will run against any documentation in the `lintingtest\source` folder. Put any documentation files you want to test in this folder. 

## Run the linting tool

1. Open a terminal window.
2. Navigate to the `lintingtest` folder.
3. Run the command `vale source/*.*`

### Check the results
You'll see any issues the linting tool has detected in your terminal. Each documentation file you tested has separate results which are listed under the filename. There are roughly 4 columns, which show:
- the line and character number of the issue
- the severity level of the issue (for example, whether it's a warning or an error)
- a description of the issue
- the rule that flagged the issue, using the folder and rule filename




