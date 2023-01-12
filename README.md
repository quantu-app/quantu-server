# QuantU Web Service

## Setup & Installation

```bash
# install gems
bundle install

# docker postgres
docker run --rm -d --name quantu-postgres \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=postgres \
    -e PGDATA=/var/lib/postgresql/data/pgdata \
	-v ${pwd}/postgresql:/var/lib/postgresql/data \
    postgres:15-alpine3.17

# create the local database
rails db:create

# migrate database
rails db:migrate

# start up the application
rails s

# run the tests
rspec
```

## Create user

```bash
rails c
User.create!(username: "nathanfaucett", email: "nathanfaucett@gmail.com", password: "password", password_confirmation: "password")
```