module Peek
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      if respond_to? :helper_method
        helper_method :peek_enabled?
        helper_method :peek_request_id
      end
    end

    protected

    def peek_enabled?
      Peek.enabled?
    end

    def peek_request_id
      request.env['action_dispatch.request_id']
    end
  end
end
