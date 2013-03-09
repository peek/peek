module Glimpse
  module Views
    class Git < View
      def initialize(options = {})
        @sha = options.delete(:sha)
        @nwo = options.delete(:nwo)
        @default_branch = options.fetch(:default_branch, 'master')
      end

      # Fetch the current Git sha if one isn't present.
      def sha
        @sha ||= `git rev-parse HEAD`.chomp
      end

      def compare_url
        "https://github.com/#{@nwo}/compare/#{@default_branch}...#{sha}"
      end
    end
  end
end
