module Glimpse
  module Views
    class Git < View
      # A view to get some insight into the current state of git
      # for your project. It gives you the sha, branch, and compare
      # url on GitHub.
      #
      # nwo             - The GitHub repository (name with owner).
      # default_branch  - master may not be your default branch.
      # branch_name     - The current branch name (Optional).
      # sha             - The current SHA for git (Optional).
      #
      # Returns Glimpse::Views::Git
      def initialize(options = {})
        @nwo = options.delete(:nwo)
        @default_branch = options.fetch(:default_branch, 'master')
        @branch_name = options.delete(:branch_name)
        @sha = options.delete(:sha)
      end

      # Fetch the current branch name.
      def branch_name
        @branch_name ||= `git rev-parse --abbrev-ref HEAD`.chomp
      end

      # Fetch the current sha if one isn't present.
      def sha
        @sha ||= `git rev-parse HEAD`.chomp
      end

      def compare_url
        "https://github.com/#{@nwo}/compare/#{@default_branch}...#{sha}"
      end
    end
  end
end
