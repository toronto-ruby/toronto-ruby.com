# Toronto Ruby

Website, Rails powered!

### Requirements
* Ruby 4.0.3
* node >= 24
* PSQL >= 14
* Rails 8.0

### Development Setup
Changes should be added via pull request, as `main` has a CI action that deploys on merge. The application relies on a PostgreSQL instance for its database, so make sure to set that up for your local environment.

ActionText is wired up (and pulls in ActiveStorage), so `libvips` is required even though no page currently uses uploads.

The database and storage configurations are provided in a `.sample` file, make sure you copy those and rename them to the correct `.yml` file. These files are git ignored, so you can set up your local environment as needed.

1. Pull/clone the repo
1. Run `bundle install`
1. Run `npm install`
1. Run `cp ./config/database.yml.sample ./config/database.yml`
1. Run `cp ./config/storage.yml.sample ./config/storage.yml`
1. Edit the two files above as needed.
1. Run `bundle exec rails db:setup`

This should get the application setup and ready to run.

### Admin authentication
Admin access (creating/editing events) is gated behind a login screen backed by a `User` model with `has_secure_password`. Admin users are seeded from the encrypted credentials under the `admins:` key — add or update entries there and re-run `bin/rails db:seed` to upsert. The credentials file also holds the `active_record_encryption` keys used to encrypt `password_digest` and `session_token` at rest. To rotate or add admins:

```
bin/rails credentials:edit
# then:
bin/rails db:seed
```

The default seeded admin is `trbadmin`.

To run the application locally, in two separate consoles:
1. Run `bin/dev` - watches and rebuilds JS and CSS (runs `Procfile.dev` via foreman)
1. Run `bin/rails s` - starts the Rails server

### Deploying to Production
This application is deployed via Dockerfile, so changes that will affect dependencies, etc should be reflected in the `Dockerfile`.


