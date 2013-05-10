require 'peek/adapters/base'
require 'dalli'

module Peek
  module Adapters
    class Memcache < Base
      def initialize(options = {})
        @client = options.fetch(:client, ::Dalli::Client.new)
        @expires_in = options.fetch(:expires_in, 60 * 30)
      end

      def get(request_id)
        @client.get("peek:requests:#{request_id}")
      end

      def save
        @client.add("peek:requests:#{Peek.request_id}", Peek.results.to_json, @expires_in)
      end
    end
  end
end
