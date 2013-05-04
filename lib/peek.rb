require 'peek/version'
require 'rails'
require 'atomic'
require 'redis'

require 'peek/views/view'
Dir[File.join(File.dirname(__FILE__), 'peek', 'views', '*.rb')].each do |view|
  require view
end
require 'peek/request'

module Peek
  class << self
    attr_accessor :_request_id
  end
  self._request_id = Atomic.new('')

  def self.request_id
    _request_id.get
  end

  def self.request_id=(id)
    _request_id.update { id }
  end

  def self.redis
    @redis ||= Redis.new
  end

  def self.redis=(redis)
    @redis = redis
  end

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

  def self.results
    results = Hash.new { |h, k| h[k] = {} }

    views.each do |view|
      if view.context?
        results[view.context_dom_id] = view.context
      end

      view.results.each do |key, value|
        results["#{view.defer_key}-#{key}"] = value
      end
    end

    results
  end

  def self.into(klass, options = {})
    @views ||= []
    @views << [klass, options]
  end

  def self.reset
    @views = nil
    @cached_views = nil
    _request_id.update { '' }
  end

  def self.setup
    ApplicationController.send(:include, Peek::ControllerHelpers)
  end
end

require 'peek/railtie'
