require 'test_helper'

class Staff < Glimpse::Views::View
  def initialize(options = {})
    @username = options.delete(:username)
  end

  def username
    @username
  end
end

describe Glimpse do
  describe "views" do
    before do
      Glimpse.reset
    end

    it "should have none by default" do
      assert_equal [], Glimpse.views
    end

    it "should be able to append views" do
      Glimpse.view Staff
      assert_kind_of Staff, Glimpse.views.first
    end

    it "should be able to append views with options" do
      Glimpse.view Staff, :username => 'dewski'
      @staff = Glimpse.views.first
      assert_kind_of Staff, @staff
      assert_equal 'dewski', @staff.username
    end
  end
end
