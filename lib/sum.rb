def sum(a)
  c = *0...a.size
  s = a.reduce([0]) {|s,x| s << s[-1] + x }
  -> *x { (r = c[*x]) && (r.empty? ? 0 : s[r.last + 1] - s[r.first]) }
end
