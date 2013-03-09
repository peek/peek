require 'glimpse/version'
Dir[File.join(File.dirname(__FILE__), 'glimpse', 'views', '*.rb')].each do |view|
  require view
end

module Glimpse
  def self.views
    @views
  end

  def self.view(klass, options = {})
    @views ||= []
    @views << [klass, options]
  end

  def self.reset
    @views = []
  end
end

require 'glimpse/railtie'
