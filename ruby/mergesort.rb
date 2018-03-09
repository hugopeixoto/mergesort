
def merge(a, b)
  r = []
  r << (a.first < b.first ? a : b).shift while a.length*b.length > 0
  return r+a+b
end

def mergesort(lst)
  return lst if lst.size == 1

  a = mergesort(lst[0, lst.size/2])
  b = mergesort(lst[lst.size/2, lst.size])
  return merge(a, b)
end

mlst = [10, 9, 8, 5, 6, 7, 4, 3, 2, 1]
sorted = mergesort(mlst)
puts sorted
