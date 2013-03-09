module Glimpse
  class Railtie < ::Rails::Engine
    config.glimpse = Glimpse

    initializer 'glimpse.setup_subscribers' do
      ActiveSupport.on_load(:after_initialize) do
        Glimpse.views
      end
    end
  end
end
