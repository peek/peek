module Peek
  module Adapters
    class Base
      def initialize(options = {})

      end

      def get(request_id)
        raise "#{self.class}#get(request_id) is not yet implemented"
      end

      def save
        raise "#{self.class}#save is not yet implemented"
      end
    end
  end
end
