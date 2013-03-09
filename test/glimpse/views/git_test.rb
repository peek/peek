require 'test_helper'

describe Glimpse::Views::Git do
  describe "compare url" do
    before do
      @git = Glimpse::Views::Git.new(:nwo => 'github/test', :sha => '123')
    end

    it "should return the full url" do
      assert_equal 'https://github.com/github/test/compare/master...123', @git.compare_url
    end
  end

  describe "sha" do
    before do
      @git = Glimpse::Views::Git.new(:sha => '123')
    end

    it "should return correct sha" do
      assert_equal '123', @git.sha
    end
  end

  describe "branch name" do
    before do
      @git = Glimpse::Views::Git.new(:sha => '123', :branch_name => 'glimpse')
    end

    it "should return correct branch name" do
      assert_equal 'glimpse', @git.branch_name
    end
  end
end
