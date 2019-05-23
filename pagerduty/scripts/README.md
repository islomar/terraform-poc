# Terraform import scripts

## General prerequisites
* Install `pipenv`, e.g. `brew install pipenv`


## User imports
* Create virtualenv with Python 2.7: `pipenv --two `
* Activate virtualenv: `pipenv shell`
* Install dependencies: `pipenv install`
* Run `python import_users.py -tp <PAGERDUTY_TOKEN>`
* To deactivate the venv, type `exit`
