use strict;
use warnings;

sub merge {
  my($s, @b) = @_;
  my(@a) = splice(@b, $s);

  if (@a * @b == 0) { return @a, @b; }
  my($head) = $a[0] < $b[0] ? shift(@a) : shift(@b);
  return $head, merge(int(@a), @a, @b);
}

sub mergesort {
  my($half) = int(@_ / 2);
  if ($half == 0) { return @_; }

  return merge($half, mergesort(splice(@_, $half)), mergesort(@_));
}

my(@sorted) = mergesort(10, 9, 8, 4, 5, 6, 7, 3, 2, 1);
print(join(" ", @sorted) . "\n");
