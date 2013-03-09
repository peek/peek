require 'test_helper'

describe Glimpse do
  describe "views" do
    before do
      Glimpse.reset
    end

    it "should have none by default" do
      assert_equal [], Glimpse.views
    end

    it "should be able to append views" do
      @view = Object.new
      Glimpse.view @view
      assert_equal [[@view, {}]], Glimpse.views
    end
  end
end
