module Peek
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      prepend_before_action :set_peek_request_id, if: :peek_enabled?
      helper_method :peek_enabled? if respond_to? :helper_method
    end

    protected

    def set_peek_request_id
      Peek.request_id = request.env['action_dispatch.request_id']
    end

    def peek_enabled?
      Peek.enabled?
    end
  end
end
