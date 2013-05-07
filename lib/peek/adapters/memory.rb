require 'peek/adapters/base'

module Peek
  module Adapters
    class Memory < Base
      def initialize(options = {})
        @requests = {}
      end

      def get(request_id)
        @requests[request_id]
      end

      def save
        @requests[Peek.request_id] = Peek.results
      end
    end
  end
end
