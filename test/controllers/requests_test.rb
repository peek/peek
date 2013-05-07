require 'test_helper'

class RequestsTest < ActionDispatch::IntegrationTest
  setup do
    Peek.adapter.reset
    Peek.reset
  end

  test "the request id is set" do
    assert_empty Peek.adapter.requests
    get '/'
    assert_not_empty Peek.adapter.requests
  end
end
