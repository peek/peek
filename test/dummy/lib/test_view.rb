require 'concurrent/atomics'

class TestView < Peek::Views::View
  class << self
    attr_accessor :counter
  end
  self.counter = Concurrent::AtomicFixnum.new

  def results
    {
      number: self.class.counter.increment
    }
  end

  def partial_path
    "peek/test_view"
  end
end
