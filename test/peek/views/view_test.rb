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

  describe "key" do
    it "should return correct key" do
      assert_equal 'view', @view.key
    end
  end

  describe "context" do
    it "should return correct context_id" do
      assert_equal 'peek-context-view', @view.context_id
    end
  end

  describe "toggling off and on" do
    it "should be enabled by default" do
      assert @view.enabled?
    end
  end
end
