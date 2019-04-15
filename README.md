# BankApi

[![Build Status](https://travis-ci.com/hebertsouza87/elixir-bank-api.svg?branch=master)](https://travis-ci.com/hebertsouza87/elixir-bank-api)
[![Coverage Status](https://coveralls.io/repos/github/hebertsouza87/elixir-bank-api/badge.svg)](https://coveralls.io/github/hebertsouza87/elixir-bank-api)

Swagger doc: https://app.swaggerhub.com/apis-docs/hebertsouza87/elixir-bank-api/0.1


#### Dev
To start your Phoenix server:

* Install dependencies with `mix deps.get`
* Create a postgres database with name `bank_api_dev` with: `createdb bank_api_dev`
* Run the migration to create the tables with `mix ecto.migrate`
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


#### Production
Environment variables:
```bash
$ export DATABASE_URL=[postgres://username:password@host:port/db_name]
$ export LOG_LEVEL=[debug|info|warn|error]
$ export POOL_SIZE=[poll size]
$ export SECRET_KEY_BASE=[secret key base]
$ export SENTRY_DNS=[sentry dns]
```
OBS: Can generate a `SECRET_KEY_BASE` with `mix phx.gen.secret`


#### Infos
* This application is running on Heroku in a URL: https://intense-scrubland-49795.herokuapp.com
* Continuous Integration with Travis: https://travis-ci.com/hebertsouza87/elixir-bank-api
* Test Coverage with Coveralls: https://coveralls.io/github/hebertsouza87/elixir-bank-api
* Code climate run `mix credo --strict` and post a comment on PR.
* The logs go to [Timber](https://app.timber.io): https://imgur.com/MVmmb9p
* The errors go to [Sentry](https://sentry.io): https://imgur.com/uXakiTI | https://imgur.com/Oc0t5Tc
