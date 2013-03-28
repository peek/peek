require 'test_helper'

describe Peek::Views::View do
  before do
    @view = Peek::Views::View.new
  end

  describe "partial path" do
    it "should return correct partial class" do
      assert_equal 'peek/views/view', @view.partial_path
    end
  end

  describe "dom_id" do
    it "should return correct dom_id" do
      assert_equal 'peek-view-view', @view.dom_id
    end
  end

  describe "defer_key" do
    it "should return correct defer_key" do
      assert_equal 'view', @view.defer_key
    end
  end

  describe "context" do
    it "should return correct context_dom_id" do
      assert_equal 'peek-context-view', @view.context_dom_id
    end
  end

  describe "toggling off and on" do
    it "should be enabled by default" do
      assert @view.enabled?
    end
  end
end
