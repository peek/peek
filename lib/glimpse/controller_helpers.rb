module Glimpse
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      helper_method :glimpse_enabled?
    end

    protected

    def glimpse_enabled?
      Glimpse.enabled?      
    end
  end
end
