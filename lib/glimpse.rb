require 'glimpse/version'

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
