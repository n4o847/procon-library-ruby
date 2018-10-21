# BEGIN

class PQueue

  Less = -1
  Greater = 1

  def initialize(c = PQueue::Less)
    @h = []
    @c = c
  end

  def empty?
    @h.empty?
  end

  def size
    @h.size
  end

  alias length size

  def push(v)
    c = @h.size
    @h.push(v)
    while c > 0
      p = (c - 1) / 2
      break if (@h[p] <=> v) != @c
      @h[c] = @h[p]
      c = p
    end
    @h[c] = v
    self
  end

  alias << push

  def pop
    return if @h.empty?
    x = @h[0]
    v = @h.pop
    n = @h.size
    p = 0
    c = 1
    while c < n
      c += 1 if c + 1 < n && (@h[c] <=> @h[c + 1]) == @c
      break if (v <=> @h[c]) != @c
      @h[p] = @h[c]
      p = c
      c = p * 2 + 1
    end
    @h[p] = v
    x
  end

end

# END


$N = 100000
$data = $N.times.map { rand($N) }

$sorted = $data.sort


require 'test/unit'

class TC < Test::Unit::TestCase

  def test_less
    que = PQueue.new
    $N.times {|i|
      que << $data[i]
    }
    assert_equal $sorted.reverse, $N.times.map { que.pop }
  end

  def test_greater
    que = PQueue.new(PQueue::Greater)
    $N.times {|i|
      que.push($data[i])
    }
    assert_equal $sorted, $N.times.map { que.pop }
  end

end


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
