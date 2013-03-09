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
    end
  end
end
