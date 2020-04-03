require 'peek/adapters/base'

module Peek
  module Adapters
    class Cache < Base
      def initialize(options = {})
        @cache = options.fetch(:cache, Rails.cache)
        @expires_in = Integer(options.fetch(:expires_in, 60 * 30))
      end

      def get(request_id)
        @cache.read("peek:requests:#{request_id}")
      end

      def save(request_id)
        return false if request_id.blank?

        @cache.write("peek:requests:#{request_id}", Peek.results.to_json, expires_in: @expires_in)
      end
    end
  end
end
