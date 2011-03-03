<?
function merge(&$lst, $start, $middle, $end)
{
  $tmp = array();
  $i = $start;
  $j = $middle;

  while ($i < $middle && $j < $end)
    $tmp[] = $lst[($lst[$i] < $lst[$j] ? $i++ : $j++)];

  $tmp = array_merge($tmp,
    array_slice($lst, $i, $middle-$i),
    array_slice($lst, $j, $end-$j));

  for ($i = $start; $i < $end; $i++)
    $lst[$i] = $tmp[$i - $start];
}

function mergesort(&$lst, $a, $b)
{
  if ($b - $a < 2)
    return;

  $half = floor(($b + $a) / 2);
  mergesort($lst, $a, $half);
  mergesort($lst, $half, $b);
  merge($lst, $a, $half, $b);
}

$lst = array(10, 9, 8, 4, 5, 6, 7, 3, 2, 1);
mergesort($lst, 0, 10);
print_r($lst);
?>
