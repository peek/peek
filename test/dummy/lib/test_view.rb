require 'concurrent/atomics'

class TestView < Peek::Views::View
  class << self
    attr_accessor :counter
  end
  self.counter = Concurrent::AtomicReference.new(0)

  def results
    self.class.counter.update { |value| value + 1 }

    {
      number: self.class.counter.value
    }
  end

  def partial_path
    "peek/test_view"
  end
end
