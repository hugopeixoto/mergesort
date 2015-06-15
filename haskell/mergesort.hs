merge a [] = a
merge [] b = b
merge as@(ah:at) bs@(bh:bt) =
	if ah <= bh
	then ah:(merge at bs)
	else bh:(merge as bt)

mergesort list
  | half == 0 = list
  | otherwise =
      let (a, b) = splitAt half list in
        merge (mergesort a) (mergesort b)

  where half = div (length list) 2

main = do
	print $ mergesort [10, 9, 8, 4, 5, 6, 7, 3, 2, 1]
