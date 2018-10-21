# https://beta.atcoder.jp/contests/atc001/submissions/3444966

# BEGIN

class UnionFind

  def initialize(n)
    @p = *0...n
    @r = [0] * n
  end

  def find(x)
    @p[x] == x ? x : @p[x] = find(@p[x])
  end

  def unite(x, y)
    x = find(x)
    y = find(y)
    return if x == y
    if @r[x] < @r[y]
      @p[x] = y
    else
      @p[y] = x
      @r[x] += 1 if @r[x] == @r[y]
    end
    nil
  end

  def same(x, y)
    find(x) == find(y)
  end

end

# END
