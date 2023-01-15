# QuantU Web Service

## Metrics
[![Coverage Status](https://coveralls.io/repos/github/quantu-app/quantu-server/badge.svg?branch=master)](https://coveralls.io/github/quantu-app/quantu-server?branch=master)

## Setup & Installation

```bash
# install gems
bundle install

# docker postgres (optional)
docker run --rm -d --name quantu-postgres \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=postgres \
    -e PGDATA=/var/lib/postgresql/data/pgdata \
	-v $(pwd)/postgresql:/var/lib/postgresql/data \
    postgres:15-alpine3.17

# create the local database dev and test databases
rails db:create
RAILS_ENV=test rails db:create

# migrate database
rails db:migrate

# run development seeds (creates users)
rails db:seed

# start up the application
rails s

# run the tests
rspec

# open up the swagger documentation
# goto: http://localhost:3000/api-docs
# login and copy and set the token you get back in the authorize button to `Bearer <token>`.
```

## How To's:

### Creating a user

```bash
> rails c
irb(main)> User.create!(username: "nathanfaucett", email: "nathanfaucett@gmail.com", password: "password", password_confirmation: "password")
```