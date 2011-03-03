alias recurse { return $eval($+($,$1),2) }

alias merge {
  if !$1 || !$2 { return $1 $2 }

  var %ta, %tb, %ha = $gettok($1,1,32), %hb = $gettok($2,1,32)

  if (%ha < %hb) { %ta = $gettok($1,2-,32) | %tb = $2 }
  else { %ta = $1 | %tb = $gettok($2,2-,32) }
  return $iif(%ha < %hb, %ha, %hb) $recurse(merge( %ta , %tb ))
}

alias mergesort {
  if ($numtok($1,32) < 2) return $1
  var %m = $floor($calc($numtok($1,32) / 2))

  var %a = $gettok($1,$+(1,-,%m),32)
  var %b = $gettok($1,$+($calc(%m + 1),-),32)  

  return $merge( $recurse(mergesort( %a )), $recurse(mergesort( %b )) )
}

echo -a $mergesort(10 9 8 4 5 6 7 3 2 1)
