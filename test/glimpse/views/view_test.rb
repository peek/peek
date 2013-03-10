require 'test_helper'

describe Glimpse::Views::View do
  before do
    @view = Glimpse::Views::View.new
  end

  describe "partial path" do
    it "should return correct partial class" do
      assert_equal 'glimpse/views/view', @view.partial_path
    end
  end

  describe "dom_id" do
    it "should return correct dom_id" do
      assert_equal 'glimpse-view-view', @view.dom_id
    end
  end

  describe "defer_key" do
    it "should return correct defer_key" do
      assert_equal 'view', @view.defer_key
    end
  end

  describe "toggling off and on" do
    it "should be enabled by default" do
      assert @view.enabled?
    end
  end
end
