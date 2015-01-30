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
    ['development', 'staging'].include? env
  end

  def self.env
    Rails.env
  end

  def self.views
    @cached_views ||= if @views && @views.any?
      @views.collect { |klass, options| klass.new(options.dup) }.select(&:enabled?)
    else
      Array.new
    end
  end

  def self.results
    results = {
      context: Hash.new,
      data: Hash.new {  |h, k| h[k] = Hash.new }
    }

    views.each do |view|
      
      results[:context][view.key] = view.context if view.context?

      view.results.each { |key, value|  results[:data][view.key][key] = value}

    end

    results
  end

  def self.into(klass, options = Hash.new)
    @views ||= Array.new
    @views << [klass, options]
  end

  # Clears out any and all views.
  #
  # Returns nothing.
  def self.reset
    @views, @cached_views = nil
  end

  # Hook that happens after every request. It is expected to reset
  # any state that Peek managed throughout the requests lifecycle.
  #
  # Returns nothing.
  def self.clear
    _request_id.update { String.new }
  end

  def self.setup
    ActiveSupport::Deprecation.warn "'Peek.setup' is deprecated and does nothing.", caller
  end
end

require 'peek/railtie'

ActiveSupport.run_load_hooks :peek, Peek
