mergesort(list) :=
  block([len: length(list), h: entier(length(list)/2)],
    if len > 1 then
      merge(mergesort(rest(list, h-len)), mergesort(rest(list, h)))
    else
      list);

merge(a, b) :=
  if length(a) * length(b) = 0 then
    append(a, b)
  else
    if first(a) < first(b) then
      cons(first(a), merge(rest(a), b))
    else
      cons(first(b), merge(a, rest(b)));
