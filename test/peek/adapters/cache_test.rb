require 'test_helper'
require 'peek/adapters/cache'

describe Peek::Adapters::Cache do
  before do
    Peek.reset
    Rails.cache.clear
  end

  describe "get" do
    before do
      @adapter = Peek::Adapters::Cache.new
      @request_id = 'dummy_request_id'
    end

    it "should return nil by default" do
      assert_nil @adapter.get(@request_id)
    end

    it "should return an empty result from an empty save" do
      @adapter.save(@request_id)
      assert_equal '{"context":{},"data":{}}', @adapter.get(@request_id)
    end
  end
end
