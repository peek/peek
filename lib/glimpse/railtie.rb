require 'glimpse/controller_helpers'

module Glimpse
  class Railtie < ::Rails::Engine
    config.glimpse = Glimpse

    initializer 'glimpse.setup_subscribers' do
      ActiveSupport.on_load(:after_initialize) do
        Glimpse.views
      end
    end

    initializer 'glimpse.include_controller_helpers' do
      config.to_prepare do
        ApplicationController.send(:include, Glimpse::ControllerHelpers)
      end
    end
  end
end
