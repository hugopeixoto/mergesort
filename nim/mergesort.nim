proc merge(left, right: var seq[int]): seq[int] =
  var list: seq[int]
  list = @[]
  while len(left) > 0 and len(right) > 0:
    if left[0] <= right[0]:
      list.add(left[0])
      left = left[1..^1]
    else:
      list.add(right[0])
      right = right[1..^1]
  while len(left) > 0:
    list.add(left[0])
    left = left[1..^1]
  while len(right) > 0:
    list.add(right[0])
    right = right[1..^1]
  return list

proc mergesort*(a: seq[int]): seq[int] =
  if a.len <= 1:
    return a
  var left : seq[int]
  var right: seq[int]
  for k, v in a:
    if k < int(len(a)/2):
      left.add(v)
    else:
      right.add(v)
  left = mergesort(left)
  right = mergesort(right)
  return merge(left, right)

var numbers = @[10, 9, 8, 4, 5, 6, 7, 3, 2, 1]
echo mergesort(numbers)
