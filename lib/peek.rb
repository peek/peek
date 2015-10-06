require 'peek/version'
require 'rails'
require 'concurrent/atomics'

require 'peek/adapters/memory'
require 'peek/views/view'

module Peek
  ALLOWED_ENVS = ['development', 'staging'].freeze

  def self._request_id
    @_request_id ||= Concurrent::Atomic.new
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

  def self.process_action_filter
    @process_action_filter
  end

  def self.process_action_filter=(callable)
    @process_action_filter = callable
  end

  def self.enabled?
    ALLOWED_ENVS.include?(env)
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
    results = {
      :context => {},
      :data => Hash.new { |h, k| h[k] = {} }
    }

    views.each do |view|
      if view.context?
        results[:context][view.key] = view.context
      end

      view.results.each do |key, value|
        results[:data][view.key][key] = value
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
    ActiveSupport::Deprecation.warn "'Peek.setup' is deprecated and does nothing.", caller
  end
end

require 'peek/railtie'

ActiveSupport.run_load_hooks(:peek, Peek)
