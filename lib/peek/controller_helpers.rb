module Peek
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      prepend_before_filter :set_peek_request_id, :if => :peek_enabled?
      helper_method :peek_enabled?
    end

    protected

    def append_info_to_payload(payload)
      super
      payload[:peek_enabled] = request.cookies['peek'] == 'true'
    end

    def set_peek_request_id
      Peek.request_id = env['action_dispatch.request_id']
    end

    def peek_enabled?
      Peek.enabled?
    end
  end
end
