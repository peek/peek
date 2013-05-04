module Peek
  class Request
    def self.get(request_id)
      Peek.redis.get("peek:requests:#{request_id}")
    end

    def self.save
      Peek.redis.setex("peek:requests:#{Peek.request_id}", 5 * 30, Peek.results.to_json)
    end
  end
end