module Glimpse
  module Views
    class View
      def partial_path
        "glimpse/views/#{self.class.to_s.split('::').last.downcase}"
      end
    end
  end
end
