
list_tail :: [Integer] -> Integer -> [Integer]
list_tail lst 0 = lst
list_tail (e:lst) n = list_tail lst (n - 1)

list_head :: [Integer] -> Integer -> [Integer]
list_head lst 0 = []
list_head (e:lst) n = e:(list_head lst (n - 1))

merge :: [Integer] -> [Integer] -> [Integer]
merge a [] = a
merge [] b = b
merge (ea:a) (eb:b) =
	if ea < eb
	then ea:(merge a (eb:b))
	else eb:(merge (ea:a) b)

mergesort :: [Integer] -> [Integer]
mergesort lst =
	let ln = toInteger (length lst)
	in
		if ln == 1
		then lst
		else merge
			(mergesort (list_head lst (div ln 2)))
			(mergesort (list_tail lst (div ln 2)))

main =
	let lst = [10, 9, 8, 4, 5, 6, 7, 3, 2, 1]
	in
	do
		print (merge_sort lst)
