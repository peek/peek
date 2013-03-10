# Glimpse

[![Build Status](https://travis-ci.org/dewski/glimpse.png?branch=master)](https://travis-ci.org/dewski/glimpse)

Provide a glimpse into your Rails application. 

## Installation

Add this line to your application's Gemfile:

    gem 'glimpse'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install glimpse

## Usage

Run the Rails generator to get Glimpse up and included into your project:

```
rails generate glimpse:install
```

This will create a file at `config/initializers/glimpse.rb` which will give you
example views to include into your Glimpse bar.

Feel free to pick and choose from the list or create your own. The order they
are added to Glimpse, the order they will appear in your bar.

```ruby
Glimpse.into Glimpse::Views::Git, :nwo => 'github/janky'
Glimpse.into Glimpse::Views::Mongo
Glimpse.into Glimpse::Views::Mysql2
Glimpse.into Glimpse::Views::Redis
```

To render the Glimpse bar in your application just add the following snippet
just before the opening `<body>` tag in your application layout.

```erb
<%= render 'glimpse/bar' %>
```

It will look something like:

```erb
<html>
  <head>
    <title>Application</title>
  </head>
  <body>
    <%= render 'glimpse/bar' %>
    <%= yield %>
  </body>
</html>
```

Some Glimpse views require the view to render before data is collected and can
be presented, ie: the number of MySQL queries ran on the page and how
long it took.

For this to work, you need to include the performance partial at the end of your
application layout.

It will look something like:

```erb
<html>
  <head>
    <title>Application</title>
  </head>
  <body>
    <%= render 'glimpse/bar' %>
    <%= yield %>
    <%= render 'glimpse/results' %>
  </body>
</html>
```

Now that you have the partials in your application, you will need to include the
assets required to make everything :sparkles:

In `app/assets/stylesheets/application.scss`:

```scss
//= require glimpse
```

In `app/assets/javascripts/application.coffee`:

```coffeescript
#= require jquery
#= require jquery_ujs
#= require glimpse
```

## Using Glimpse with PJAX

When using PJAX requests won't render default application layout which ends
up not including the required results partial. It's fairly simple to work around
if you're using the [pjax_rails](https://github.com/rails/pjax_rails) gem.

Create a new layout at `app/views/layouts/pjax.html.erb`:

```erb
<%= yield %>
<%= render 'glimpse/results' %>
```

Now you'll just need use the PJAX layout:

```ruby
class ApplicationController < ActionController::Base
  def pjax_layout
    'pjax'
  end
end
```

You're done! Now every time a PJAX request is made, the Glimpse bar will update with
the data of the PJAX request.

## Available Glimpse views

- [glimpse-git](https://github.com/dewski/glimpse-git)
- [glimpse-mongo](https://github.com/dewski/glimpse-mongo)
- [glimpse-mysql2](https://github.com/dewski/glimpse-mysql2)
- [glimpse-pg](https://github.com/dewski/glimpse-pg)
- [glimpse-redis](https://github.com/dewski/glimpse-redis)
- Navigation Time
- Unicorn

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
