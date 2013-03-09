module Glimpse
  module Views
    class ActiveRecord < View
      def initialize(options = {})
        @queries = []
        @query_times = []

        setup_subscribers
      end

      def queries
        Array(@queries)
      end

      def query_times
        @query_times
      end

      def duration
        @query_times.inject(&:+) || 0
      end

      def formatted_duration
        "%.2fms" % (duration * 1000)
      end

      def results
        { :duration => formatted_duration, :queries => queries }
      end

      private

      def setup_subscribers
        before_request do
          @queries.clear
          @query_times.clear
        end

        # Capture all queries except CACHE and SCHEMA queries.
        subscribe 'sql.active_record' do |name, start, finish, id, payload|
          unless %w(CACHE SCHEMA).include?(payload[:name])
            @queries << payload[:sql]
            @query_times << (finish - start)
          end
        end
      end
    end
  end
end
