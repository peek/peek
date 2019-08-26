require 'test_helper'
require_relative '../dummy/lib/test_view'

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

  test "the request ID and data are set correctly for concurrent requests" do
    Peek.into TestView
    concurrent_requests = 10

    assert_empty Peek.adapter.requests

    concurrent_requests.times.map do
      Thread.new { get '/' }
    end.map(&:join)

    result_sequence = Peek.adapter.requests.values.map { |value| value[:data]['test-view'][:number] }

    assert_equal Peek.adapter.requests.length, concurrent_requests
    assert_equal result_sequence, 1.upto(concurrent_requests).to_a
  end
end
