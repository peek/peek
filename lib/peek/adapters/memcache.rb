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
      rescue ::Dalli::DalliError => e
        Rails.logger.error "#{e.class.name}: #{e.message}"
      end

      def save(request_id)
        return false if request_id.blank?

        @client.add("peek:requests:#{request_id}", Peek.results.to_json, @expires_in)
      rescue ::Dalli::DalliError => e
        Rails.logger.error "#{e.class.name}: #{e.message}"
      end
    end
  end
end
