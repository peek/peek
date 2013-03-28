module Peek
  module Views
    class View
      def initialize(options = {})
        @options = options

        setup_subscribers
      end

      # Conditionally enable views based on any gathered data. Helpful
      # if you don't want views to show up when they return 0 or are
      # touched during the request.
      #
      # Returns true.
      def enabled?
        true
      end

      # The path to the partial that will be rendered to the Peek bar.
      #
      # Examples:
      #
      #   Peek::Views::PerformanceBar.partial_path => "peek/views/performance_bar"
      #   CustomResque.partial_path => "performance_bar"
      #
      # Returns String.
      def partial_path
        self.class.to_s.underscore
      end

      # The defer key that is derived from the classname.
      #
      # Examples:
      #
      #   Peek::Views::PerformanceBar => "performance-bar"
      #   Peek::Views::Resque => "resque"
      #
      # Returns String.
      def defer_key
        self.class.to_s.split('::').last.underscore.gsub(/\_/, '-')
      end

      # The context dom id that is derived from the classname.
      #
      # Examples:
      #
      #   Peek::Views::PerformanceBar => "peek-context-performance-bar"
      #   Peek::Views::Resque => "peek-context-resque"
      #
      # Returns String.
      def context_dom_id
        "peek-context-#{defer_key}"
      end

      # The wrapper ID for the individual view in the Peek bar.
      #
      # Returns String.
      def dom_id
        "peek-view-#{defer_key}"
      end

      # Additional context for any view to render tooltips for.
      #
      # Returns Hash.
      def context
        {}
      end

      def context?
        context.any?
      end

      # The data results that are inserted at the end of the request for use in
      # deferred placeholders in the Peek the bar.
      #
      # Returns Hash.
      def results
        {}
      end

      def results?
        results.any?
      end

      def subscribe(*args)
        ActiveSupport::Notifications.subscribe(*args) do |name, start, finish, id, payload|
          yield name, start, finish, id, payload
        end
      end

      private

      def setup_subscribers
        # pass
      end

      # Helper method for subscribing to the event that is fired when new
      # requests are made.
      def before_request
        subscribe 'start_processing.action_controller' do |name, start, finish, id, payload|
          yield name, start, finish, id, payload
        end
      end
    end
  end
end
