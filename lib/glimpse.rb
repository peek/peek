require 'glimpse/version'
require 'rails'

require 'glimpse/views/view'
Dir[File.join(File.dirname(__FILE__), 'glimpse', 'views', '*.rb')].each do |view|
  require view
end

module Glimpse
  def self.enabled?
    Rails.env.development?
  end

  def self.env
    Rails.env
  end

  def self.views
    @cached_views ||= if @views && @views.any?
      @views.collect { |klass, options| klass.new(options.dup) }.select(&:enabled?)
    else
      []
    end
  end

  def self.into(klass, options = {})
    @views ||= []
    @views << [klass, options]
  end

  def self.reset
    @views = nil
    @cached_views = nil
  end
end

require 'glimpse/railtie'
