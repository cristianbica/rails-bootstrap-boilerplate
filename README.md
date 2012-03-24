## What's this?

An empty Rails application hooked up with some basic stuff: inherited_resources, has_scope, delayed_job, simple-navigation, rspec, twitter bootstrap integration, some scaffold generators

## Details

### Basic

* [haml-rails](http://github.com/indirect/haml-rails) - templates
* [less-rails](http://github.com/metaskills/less-rails) - stylesheets
* [coffee-rails](https://github.com/rails/coffee-rails) - javascripts
* [simple-navigation](http://github.com/andi/simple-navigation) - navigation menus
* [delayed_job_active_record](http://github.com/collectiveidea/delayed_job_active_record) - background jobs
* [devise](http://github.com/plataformatec/devise) - authentication
* [cancan](http://github.com/ryanb/cancan) - authorization
* [state_machine](http://github.com/pluginaweek/state_machine) - state machine
* [http://github.com/josevalim/inherited_resources](https://github.com/) - controller restful actions 
* [has_scope](https://github.com/plataformatec/has_scope) - Maps controller filters to your resource scopes
* [kaminari](https://github.com/amatsuda/kaminari) - pagination
* [twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails) - Twitter bootstrap integration
* [bootstrap_kaminari](https://github.com/dleavitt/bootstrap_kaminari) - pagination template for twitter bootstrap

### Twitter bootstrap

The application is themed by bootstrap. Simple form generates the forms for bootstrap. Pagination is styled by bootstrap_kaminari. Also there's an app:scaffold generator that make some pretty nice pages :)

### RSpec

* [factory_girl](https://github.com/thoughtbot/factory_girl) - fixtures
* [ffaker](https://github.com/EmmanuelOga/ffaker) - fake data generation
* [mocha](https://rubygems.org/gems/mocha) - mocking
* [spork](https://github.com/sporkrb/spork) + [guard](https://github.com/guard/guard) + guard-spork + guard-rspec + guard-bundler - TDD :)


## Howto

* Clone the repo
* setup config/database.yml
* rake db:migrate
* done!

## Howto use the app:scaffold
* rails g model model field1:type field2:type
* rake db:migrate
* rails g app:scaffold pluralized_model
* now you can configure the model, controller, view

NOTE: don't forget to setup the cancan ability. By default all users can manage everything

## TODO

* more detailed explanation
* write tests for user model, authentication, authorization
* setup integration tests
* enable OAuth
* enable registration
* localize for other languages
* add roles to users for better authorization management
* make this a gem with a generator that does all the setup

