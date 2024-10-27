# Toronto Ruby

Website, Rails powered!

### Requirements
* Ruby 3.2.2
* node >= 20
* PSQL >= 14

### Development Setup
Changes should be added via merge request, as `main` has a CI action that deploys on merge. The application relies on a PostgreSQL instance for its database, so make sure to set that up for your local environment.

Because we use ActionText, the application does require dependencies for ActiveStorage as well (ie, `libvips`) though these are currently not used.

The database and storage configurations are provided in a `.sample` file, make sure you copy those and rename them to the correct `.yml` file. These files are git ignored, so you can set up your local environment as needed.

1. Pull/clone the repo
1. Run `bundle install`
1. Run `npm install`
1. Run `cp ./config/database.yml.sample ./config/database.yml`
1. Run `cp ./config/storage.yml.sample ./config/storage.yml`
1. Edit the two files above as needed.
1. Run `bundle exec rails db:setup`

This should get the application setup and ready to run.

To run the application locally:
1. Run `bin/dev` - this command will watch JS and CSS to rebuild
1. Run `bundle exec rails s` - this command will run the Rails server

### Deploying to Production
This application is deployed via Dockerfile, so changes that will affect dependencies, etc should be reflected in the `Dockerfile`.


