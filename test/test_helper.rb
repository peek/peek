ENV['RAILS_ENV'] = "test"

require 'peek'

require 'minitest/autorun'

begin
  require 'turn'
rescue LoadError
  # Not installed.
end
