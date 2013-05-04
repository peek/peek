require 'peek/controller_helpers'

module Peek
  class Railtie < ::Rails::Engine
    isolate_namespace Peek
    engine_name :peek

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

    initializer 'peek.persist_request_data' do
      ActiveSupport::Notifications.subscribe('process_action.action_controller') do
        Peek.save
        Peek._request_id.update { '' }
      end
    end
  end
end
