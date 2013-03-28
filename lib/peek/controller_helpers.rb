module Peek
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      helper_method :peek_enabled?
    end

    protected

    def peek_enabled?
      Peek.enabled?      
    end
  end
end
