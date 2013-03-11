ENV['RAILS_ENV'] = "test"

require 'glimpse'

require 'minitest/autorun'

begin
  require 'turn'
rescue LoadError
  # Not installed.
end
