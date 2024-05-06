# Toronto Ruby

Website, Rails powered!

### Requirements
* Ruby 3.2.2
* yarn 1.22.6
* node >= 20

### Development Setup
Changes should be added via merge request, as `main` has a CI action that deploys on merge.

Currently, the application does not require any database and so defaults to SQLite, but this might change in the future.

1. Pull/clone the repo
1. `bundle install`
1. `yarn install`

This should get the application setup.

To run development, run `bin/dev` - this command will watch JS and CSS to rebuild and run the Rails server


