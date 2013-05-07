require 'peek/version'
require 'rails'
require 'atomic'

require 'peek/adapters/memory'
require 'peek/views/view'

module Peek
  def self._request_id
    @_request_id ||= Atomic.new
  end

  def self.request_id
    _request_id.get
  end

  def self.request_id=(id)
    _request_id.update { id }
  end

  def self.adapter
    @adapter
  end

  def self.adapter=(*adapter_options)
    adapter, *parameters = *Array.wrap(adapter_options).flatten

    @adapter = case adapter
    when Symbol
      adapter_class_name = adapter.to_s.camelize
      adapter_class =
        begin
          require "peek/adapters/#{adapter}"
        rescue LoadError => e
          raise "Could not find adapter for #{adapter} (#{e})"
        else
          Peek::Adapters.const_get(adapter_class_name)
        end
      adapter_class.new(*parameters)
    when nil
      Peek::Adapters::Memory.new
    else
      adapter
    end

    @adapter
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

  # Clears out any and all views.
  #
  # Returns nothing.
  def self.reset
    @views = nil
    @cached_views = nil
  end

  # Hook that happens after every request. It is expected to reset
  # any state that Peek managed throughout the requests lifecycle.
  #
  # Returns nothing.
  def self.clear
    _request_id.update { '' }
  end

  def self.setup
    ApplicationController.send(:include, Peek::ControllerHelpers)
  end
end

require 'peek/railtie'

ActiveSupport.run_load_hooks(:peek, Peek)
