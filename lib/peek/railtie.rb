require 'peek/controller_helpers'

module Peek
  class Railtie < ::Rails::Engine
    isolate_namespace Peek
    engine_name :peek

    config.peek = ActiveSupport::OrderedOptions.new

    # Default adapter
    config.peek.adapter = :memory

    initializer 'peek.set_configs' do |app|
      ActiveSupport.on_load(:peek) do
        app.config.peek.each do |k,v|
          send "#{k}=", v
        end
      end
    end

    initializer 'peek.persist_request_data' do
      ActiveSupport::Notifications.subscribe('process_action.action_controller') do |_name, _start, _finish, _id, payload|
        if request_id = payload[:headers].env['action_dispatch.request_id']
          Peek.adapter.save(request_id)
        end
      end
    end

    initializer 'peek.include_controller_helpers' do
      ActiveSupport.on_load(:action_controller) do
        include Peek::ControllerHelpers
      end

      config.to_prepare do
        Peek.views
      end
    end
  end
end
