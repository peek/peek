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
        "glimpse/views/#{self.class.to_s.split('::').last.downcase}"
      end
    end
  end
end
