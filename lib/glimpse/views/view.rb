module Glimpse
  module Views
    class View
      def initialize(options = {})
        @options = options
      end

      def enabled?
        true
      end

      def partial_path
        self.class.to_s.underscore
      end

      def defer_key
        self.class.to_s.split('::').last.underscore.gsub(/\_/, '-')
      end

      def results
        {}
      end

      def subscribe(*args)
        ActiveSupport::Notifications.subscribe(*args) do |name, start, finish, id, payload|
          yield name, start, finish, id, payload
        end
      end
    end
  end
end
