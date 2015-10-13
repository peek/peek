require 'test_helper'

class RequestsTest < ActionDispatch::IntegrationTest
  include ActiveSupport::Testing::MethodCallAssertions

  setup do
    Peek.adapter.reset
    Peek.reset
  end

  test "the request id is set when the peek cookie is set" do
    assert_empty Peek.adapter.requests
    cookies['peek'] = 'true'
    get '/'
    assert_not_empty Peek.adapter.requests
  end

  test "saves results if the peek cookie is set" do
    cookies['peek'] = 'true'
    assert_called(Peek.adapter, :save) do
      get '/'
    end
  end

  test "does not save results if the peek cookie is not set" do
    assert_not_called(Peek.adapter, :save) do
      get '/'
    end
  end
end
