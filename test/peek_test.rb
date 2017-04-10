require 'test_helper'

class Staff < Peek::Views::View
  def initialize(options = {})
    @username = options.delete(:username)
  end

  def username
    @username
  end

  def enabled?
    !!@username
  end
end

describe Peek do
  describe "enabled?" do
    it "should not be enabled in test" do
      refute Peek.enabled?
    end
  end

  describe "env" do
    it "should return the current environment" do
      assert_equal 'test', Peek.env
    end
  end

  describe "views" do
    before do
      Peek.reset
    end

    it "should have none by default" do
      assert_equal [], Peek.views
    end

    it "should be able to append views" do
      Peek.into Staff, username: 'dewski'
      assert_kind_of Staff, Peek.views.first
    end

    it "should be able to append views with options" do
      Peek.into Staff, username: 'dewski'
      @staff = Peek.views.first
      assert_kind_of Staff, @staff
      assert_equal 'dewski', @staff.username
    end

    it "should only return enabled views" do
      Peek.into Staff, username: false
      assert_equal [], Peek.views
    end
  end

  describe "reset" do
    before do
      Peek.reset
    end

    it "should clear any current views" do
      Peek.into Staff, username: 'dewski'
      assert_kind_of Staff, Peek.views.first
      Peek.reset
      assert_equal [], Peek.views
    end
  end
end
