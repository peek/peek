require 'test_helper'

describe Glimpse::Views::View do
  describe "partial path" do
    it "should return correct partial class" do
      @view = Glimpse::Views::View.new
      assert_equal 'views/view', @view.partial_path
    end
  end
end
