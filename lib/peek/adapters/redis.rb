require 'peek/adapters/base'
require 'redis'

module Peek
  module Adapters
    class Redis < Base
      def initialize(options = {})
        @client = options.fetch(:client, ::Redis.new)
        @expires_in = Integer(options.fetch(:expires_in, 60 * 30))
      end

      def get(request_id)
        @client.get("peek:requests:#{request_id}")
      end

      def save
        @client.setex("peek:requests:#{Peek.request_id}", @expires_in, Peek.results.to_json)
      end
    end
  end
end
