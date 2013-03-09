module Glimpse
  module Views
    class Git
      def initialize(options = {})
        @sha = options.delete(:sha)
        @nwo = options.delete(:nwo)
      end

      # Fetch the current Git sha if one isn't present.
      def sha
        @sha ||= `git rev-parse HEAD`.chomp
      end

      def compare_url
        "https://github.com/#{nwo}/compare/master...#{sha}"
      end
    end
  end
end
