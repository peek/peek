require 'peek/adapters/base'
require 'elasticsearch'

module Peek
  module Adapters
    class Elasticsearch < Base
      def initialize(options = {})
        @client = options.fetch(:client, ::Elasticsearch::Client.new)
        @expires_in = Integer(options.fetch(:expires_in, 60 * 30) * 1000)
      end

      def get(request_id)
        begin
          result = @client.get_source index: 'peek_requests_index', type: 'peek_request', id: "#{request_id}"
        rescue ::Elasticsearch::Transport::Transport::Errors::NotFound
          result = false
        end

        if result
          result.to_json
        else
          nil
        end
      end

      def save
        begin
          @client.index index: 'peek_requests_index',
                        type: 'peek_request',
                        id: "#{Peek.request_id}",
                        body: Peek.results.to_json,
                        ttl: @expires_in
        rescue ::Elasticsearch::Transport::Transport::Errors::BadRequest
          false
        end
      end

    end
  end
end
