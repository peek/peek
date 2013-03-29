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

To pick which views you want to see in your Peek bar, just create a file at
`config/initializers/peek.rb` that has a list of the views you'd like to see:

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

Some Peek views require the view to render before data is collected and can
be presented, ie: the number of MySQL queries ran on the page and how
long it took.

For this to work, you need to include the `peek/results` partial at the end of your
application layout.

It will look like:

```erb
<html>
  <head>
    <title>Application</title>
  </head>
  <body>
    <%= render 'peek/bar' %>
    <%= yield %>
    <%= render 'peek/results' %>
  </body>
</html>
```

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

## Using Peek with PJAX

When using [PJAX](https://github.com/defunkt/jquery-pjax) in your application, by default requests won't render the
application layout which ends up not including the required results partial.
It's fairly simple to get this working with PJAX if you're using the
[pjax_rails](https://github.com/rails/pjax_rails) gem.

Create a new layout at `app/views/layouts/peek.html.erb`:

```erb
<%= yield %>
<%= render 'peek/results' %>
```

Now you'll just need use the PJAX layout:

```ruby
class ApplicationController < ActionController::Base
  def pjax_layout
    'peek'
  end
end
```

You're done! Now every time a PJAX request is made, the Peek bar will update
with the Peek results of the PJAX request.

## Using Peek with Turbolinks

It just works.

## Access Control

You probably don't want to give this data to ALL your users. So by default Peek
only shows up in development or staging environments. If you'd like to restrict Peek
to a select few users, you can do so by overriding the `peek_enabled?` guard in
ApplicationController.

```ruby
class ApplicationController < ActionController::Base
  def peek_enabled?
    current_user.staff?
  end
end
```

## Available Peek items

- [peek-dalli](https://github.com/peek/peek-dalli)
- [peek-git](https://github.com/peek/peek-git)
- [peek-mongo](https://github.com/peek/peek-mongo)
- [peek-mysql2](https://github.com/peek/peek-mysql2)
- [peek-performance_bar](https://github.com/peek/peek-performance_bar)
- [peek-pg](https://github.com/peek/peek-pg)
- [peek-redis](https://github.com/peek/peek-redis)
- [peek-resque](https://github.com/peek/peek-resque)
- [glimpse-sidekiq](https://github.com/suranyami/glimpse-sidekiq)
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

### Using Peek with Spork

For best results with Spork, add this to your `prefork` block
anytime before your environment is loaded:

```ruby
require 'peek'
Spork.trap_class_method(Peek, :setup)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
