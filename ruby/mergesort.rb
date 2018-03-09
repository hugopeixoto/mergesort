def merge(a, b)
  r = []
  r << (a.first < b.first ? a : b).shift until a.empty? || b.empty?
  r + a + b
end

def mergesort(lst)
  return lst if lst.size == 1

  a, b = lst.each_slice((lst.size + 1) / 2).to_a

  merge(mergesort(a), mergesort(b))
end

puts mergesort([10, 9, 8, 5, 6, 7, 4, 3, 2, 1])
