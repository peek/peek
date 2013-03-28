require 'peek/controller_helpers'

module Peek
  class Railtie < ::Rails::Engine
    config.peek = Peek

    initializer 'peek.setup_subscribers' do
      ActiveSupport.on_load(:after_initialize) do
        Peek.views
      end
    end

    initializer 'peek.include_controller_helpers' do
      config.to_prepare do
        Peek.setup
      end
    end
  end
end
