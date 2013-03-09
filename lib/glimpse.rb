require 'glimpse/version'
require 'rails'

require 'glimpse/views/view'
Dir[File.join(File.dirname(__FILE__), 'glimpse', 'views', '*.rb')].each do |view|
  require view
end

module Glimpse
  def self.views
    @views.collect { |klass, options| klass.new(options) }
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
