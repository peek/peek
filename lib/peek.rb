require 'peek/version'
require 'rails'

require 'peek/views/view'
Dir[File.join(File.dirname(__FILE__), 'peek', 'views', '*.rb')].each do |view|
  require view
end

module Peek
  def self.enabled?
    ['development', 'staging'].include?(env)
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

  def self.setup
    ApplicationController.send(:include, Peek::ControllerHelpers)
  end
end

require 'peek/railtie'
