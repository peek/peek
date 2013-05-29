# Peek

[![Build Status](https://travis-ci.org/peek/peek.png?branch=master)](https://travis-ci.org/peek/peek)

Take a peek into your Rails application.

![Preview](https://f.cloud.github.com/assets/79995/244991/03cee1fa-8a74-11e2-8e33-283cf1298a60.png)

This was originally built at GitHub to help us get insight into what's going
on, this is just an extraction so other Rails applications can have the same.

## Installation

Add this line to your application's Gemfile:

    gem 'peek'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install peek

## Usage

Now that Peek is installed, you'll need to mount the engine within your `config/routes.rb`
file:

```ruby
Some::Application.routes.draw do
  mount Peek::Railtie => '/peek'
  root :to => 'home#show'
end
```

To pick which views you want to see in your Peek bar, just create a file at
`config/initializers/peek.rb` that has a list of the views you'd like to include:

```ruby
Peek.into Peek::Views::Git, :nwo => 'github/janky'
Peek.into Peek::Views::Mysql2
Peek.into Peek::Views::Redis
Peek.into Peek::Views::Dalli
```

Feel free to pick and choose from the list or create your own. The order they
are added to Peek, the order they will appear in your bar.

Next, to render the Peek bar in your application just add the following snippet
just after the opening `<body>` tag in your application layout.

```erb
<%= render 'peek/bar' %>
```

It will look like:

```erb
<html>
  <head>
    <title>Application</title>
  </head>
  <body>
    <%= render 'peek/bar' %>
    <%= yield %>
  </body>
</html>
```

Peek fetches the data collected throughout your requests by using the unique request id
that was assigned to the request by Rails. It will call out to its own controller at
[Peek::ResultsController](https://github.com/peek/peek/blob/master/app/controllers/peek/results_controller.rb) which will render the data and be inserted into the bar.

Now that you have the partials in your application, you will need to include the
CSS and JS that help make Peek :sparkles:

In `app/assets/stylesheets/application.scss`:

```scss
//= require peek
```

In `app/assets/javascripts/application.coffee`:

```coffeescript
#= require jquery
#= require jquery_ujs
#= require peek
```

Note: Each additional view my have their own CSS and JS you need to require
which should be stated in their usage documentation.

### Configuring the default adapter

For Peek to work, it keeps track of all requests made in your application
so it can report back and display that information in the Peek bar. By default
it stores this information in memory, which is not recommended for production environments.

In production environments you may have application servers on multiple hosts,
at which Peek will not be able to access the request data if it was saved in memory on
another host. Peek provides 2 additional adapters for multi server environments.

You can configure which adapter Peek uses by updating your application
config or an individual environment config file. We'll use production as an example.

Note: Peek does not provide the dependencies for each of these adapters. If you use these
adapters be sure to include their dependencies in your application.

- Redis - The [redis](https://github.com/redis/redis-rb) gem
- Dalli - The [dalli](https://github.com/mperham/dalli) gem

```ruby
Peeked::Application.configure do
  # ...

  # Redis with no options
  config.peek.adapter = :redis

  # Redis with options
  config.peek.adapter = :redis, {
    :client => Redis.new,
    :expires_in => 60 * 30 # => 30 minutes in seconds
  }

  # Memcache with no options
  config.peek.adapter = :memcache

  # Memcache with options
  config.peek.adapter = :memcache, {
    :client => Dalli::Client.new,
    :expires_in => 60 * 30 # => 30 minutes in seconds
  }

  # ...
end
```

Peek doesn't persist the request data forever. It uses a safe 30 minute
cache length that way data will be available if you'd like to aggregate it or
use it for other Peek views. You can update this to be 30 seconds if you don't
want the data to be available to stick around.

## Using Peek with PJAX

It just works.

## Using Peek with Turbolinks

It just works.

## Using Peek with Spork

For best results with Spork, add this to your `prefork` block
anytime before your environment is loaded:

```ruby
require 'peek'
Spork.trap_class_method(Peek, :setup)
```

## Access Control

Peek will only render in development and staging environments. If you'd
like to whitelist a select number of users to view Peek in production you
can override the `peek_enabled?` guard in `ApplicationController`:

```ruby
class ApplicationController < ActionController::Base
  def peek_enabled?
    current_user.staff?
  end
end
```

## Available Peek views

- [peek-dalli](https://github.com/peek/peek-dalli)
- [peek-git](https://github.com/peek/peek-git)
- [peek-mongo](https://github.com/peek/peek-mongo)
- [peek-mysql2](https://github.com/peek/peek-mysql2)
- [peek-performance_bar](https://github.com/peek/peek-performance_bar)
- [peek-pg](https://github.com/peek/peek-pg)
- [peek-rblineprof](https://github.com/peek/peek-rblineprof)
- [peek-redis](https://github.com/peek/peek-redis)
- [peek-resque](https://github.com/peek/peek-resque)
- [peek-sidekiq](https://github.com/suranyami/peek-sidekiq)
- [peek-faraday](https://github.com/grk/peek-faraday)
- [glimpse-svn](https://github.com/neilco/glimpse-svn)
- Unicorn :soon:

Feel free to submit a Pull Request adding your own Peek item to this list.

## Creating your own Peek item

Each Peek item is a self contained Rails engine which gives you the power to
use all features of Ruby on Rails to dig in deep within your application and
report it back to the Peek bar. A Peek item is just a custom class that
is responsible for fetching and building the data that should be reported back
to the user.

There are still some docs to be written, but if you'd like to checkout a simple
example of how to create your own, just checkout [peek-git](https://github.com/peek/peek-git).
To just look at an example view, there is [Peek::Views::Git](https://github.com/peek/peek-git/blob/master/lib/peek/views/git.rb).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
