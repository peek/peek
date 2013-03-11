# Glimpse

[![Build Status](https://travis-ci.org/dewski/glimpse.png?branch=master)](https://travis-ci.org/dewski/glimpse)

Provide a glimpse into your Rails application.

![Preview](https://f.cloud.github.com/assets/79995/244991/03cee1fa-8a74-11e2-8e33-283cf1298a60.png)

This was originally built at GitHub to help us get insight into what's going
on, this is just an extraction so other Rails applications can have the same.

## Installation

Add this line to your application's Gemfile:

    gem 'glimpse'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install glimpse

## Usage

To pick which views you want to see in your Glimpse bar, just create a file at
`config/initializers/glimpse.rb` that has a list of the views you'd like to see:

```ruby
Glimpse.into Glimpse::Views::Git, :nwo => 'github/janky'
Glimpse.into Glimpse::Views::Mongo
Glimpse.into Glimpse::Views::Mysql2
Glimpse.into Glimpse::Views::Redis
```

Feel free to pick and choose from the list or create your own. The order they
are added to Glimpse, the order they will appear in your bar.

Next, to render the Glimpse bar in your application just add the following snippet
just after the opening `<body>` tag in your application layout.

```erb
<%= render 'glimpse/bar' %>
```

It will look like:

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

For this to work, you need to include the `glimpse/results` partial at the end of your
application layout.

It will look like:

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
CSS and JS that help make Glimpse :sparkles:

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

Note: Each additional view my have their own CSS and JS you need to require.

## Using Glimpse with PJAX

When using PJAX in your application, by default requests won't render the
application layout which ends up not including the required results partial.
It's fairly simple to get this working with PJAX if you're using the
[pjax_rails](https://github.com/rails/pjax_rails) gem.

Create a new layout at `app/views/layouts/glimpse.html.erb`:

```erb
<%= yield %>
<%= render 'glimpse/results' %>
```

Now you'll just need use the PJAX layout:

```ruby
class ApplicationController < ActionController::Base
  def pjax_layout
    'glimpse'
  end
end
```

You're done! Now every time a PJAX request is made, the Glimpse bar will update
with the Glimpse results of the PJAX request.

## Access Control

You probably don't want to give this data to ALL your users. So by default Glimpse
only shows up in development or staging environments. If you'd like to restrict Glimpse
to a select few users, you can do so by overriding the `glimpse_enabled?` guard in
ApplicationController.

```ruby
class ApplicationController < ActionController::Base
  def glimpse_enabled?
    current_user.staff?
  end
end
```

## Available Glimpse items

- [glimpse-dalli](https://github.com/dewski/glimpse-dalli)
- [glimpse-git](https://github.com/dewski/glimpse-git)
- [glimpse-mongo](https://github.com/dewski/glimpse-mongo)
- [glimpse-mysql2](https://github.com/dewski/glimpse-mysql2)
- [glimpse-pg](https://github.com/dewski/glimpse-pg)
- [glimpse-redis](https://github.com/dewski/glimpse-redis)
- [glimpse-resque](https://github.com/dewski/glimpse-resque)
- Navigation Time :soon:
- Unicorn :soon:

## Creating your own Glimpse item

Each Glimpse item is a self contained Rails engine which gives you the power to
use all features of Ruby on Rails to dig in deep within your application and
report it back to the Glimpse bar. A Glimpse item is just a custom class that
is responsible for fetching and building the data that should be reported back
to the user.

There are still some docs to be written, but if you'd like to checkout a simple
example of how to create your own, just checkout [glimpse-git](https://github.com/dewski/glimpse-git).
To just look at an example view, there is [Glimpse::Views::Git](https://github.com/dewski/glimpse-git/blob/master/lib/glimpse/views/git.rb).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
