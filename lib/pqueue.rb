# BEGIN

class PQueue

  Less = -1
  Greater = 1

  def initialize(c = Less)
    @h = [nil]
    @c = c
  end

  def empty?
    @h.size == 1
  end

  def size
    @h.size - 1
  end

  alias length size

  def push(v)
    c = @h.size
    @h.push(v)
    while c > 1
      p = c / 2
      break if (@h[p] <=> v) != @c
      @h[c] = @h[p]
      c = p
    end
    @h[c] = v
    self
  end

  alias << push

  def pop
    return if @h.size == 1
    x = @h[1]
    v = @h.pop
    n = @h.size
    p = 1
    c = 2
    while c < n
      c += 1 if c + 1 < n && (@h[c] <=> @h[c + 1]) == @c
      break if (v <=> @h[c]) != @c
      @h[p] = @h[c]
      p = c
      c = p * 2
    end
    @h[p] = v
    x
  end

end

# END


if ARGV.include?("test")

  require 'test/unit'

  class TC < Test::Unit::TestCase

    def test_less
      n = 100
      data = n.times.map { rand }
      que = PQueue.new
      n.times {|i|
        que << data[i]
      }
      assert_equal data.sort.reverse, n.times.map { que.pop }
    end

    def test_greater
      n = 100
      data = n.times.map { rand }
      que = PQueue.new(PQueue::Greater)
      n.times {|i|
        que.push(data[i])
      }
      assert_equal data.sort, n.times.map { que.pop }
    end

  end

end

if ARGV.include?("bm")

  $N = 100000
  $data = $N.times.map { rand($N) }

  require 'benchmark'

  Benchmark.bm(10) {|x|

    x.report("pqueue") {
      que = PQueue.new
      $N.times {|i|
        que.push($data[i])
      }
      $N.times {
        que.pop
      }
    }

    x.report("sort once") {
      que = Array.new
      $N.times {|i|
        que.push($data[i])
      }
      que.sort
      $N.times {
        que.pop
      }
    }

    x.report("bsearch") {
      que = Array.new
      $N.times {|i|
        pos = que.bsearch_index{|x| (x <=> $data[i]) == 1 }
        if pos
          que.insert(pos, $data[i])
        else
          que.push($data[i])
        end
      }
      $N.times {
        que.pop
      }
    }

  }

end
