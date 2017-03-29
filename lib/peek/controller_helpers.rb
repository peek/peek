module Peek
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      if Rails::VERSION::MAJOR >= 4 && Rails::VERSION::MINOR >= 2
        prepend_before_action :set_peek_request_id, :if => :peek_enabled?
      else
        prepend_before_filter :set_peek_request_id, :if => :peek_enabled?
      end
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
