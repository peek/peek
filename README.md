# Glimpse

Provide a glimpse into your Rails applications.

## Installation

Add this line to your application's Gemfile:

    gem 'glimpse'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install glimpse

## Usage

```ruby
Glimpse.view Glimpse::Git, :github => 'github/hire'
Glimpse.view Glimpse::NavigationTime
Glimpse.view Glimpse::Unicorn
Glimpse.view Glimpse::ActiveRecord
Glimpse.view Glimpse::Redis
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
