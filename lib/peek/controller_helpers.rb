module Peek
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      prepend_before_action :set_peek_request_id, :if => :peek_enabled?
      helper_method :peek_enabled? if respond_to? :helper_method
    end

    protected

    def append_info_to_payload(payload)
      super
      payload[:peek_bar_visible] = peek_bar_visible?
    end

    def peek_bar_visible?
      request.cookies['peek'] == 'true'
    end

    def set_peek_request_id
      Peek.request_id = request.env['action_dispatch.request_id']
    end

    def peek_enabled?
      Peek.enabled?
    end
  end
end
