require 'test_helper'

describe Glimpse::Views::Git do
  before do
    @git = Glimpse::Views::Git.new(:nwo => 'github/test', :sha => '123')
  end

  describe "compare url" do
    it "should return the full url" do
      assert_equal 'https://github.com/github/test/compare/master...123', @git.compare_url
    end
  end
end
