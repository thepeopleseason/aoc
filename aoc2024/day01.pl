#!/usr/bin/perl -l -F/\s+/

END {
  my ($sl, $sr) = ([sort {$a <=> $b} @ll], [sort {$a <=> $b} @rl]);
  for ($x=0; $x<=$#ll; $x++) {
    $sum += abs($sl->[$x] - $sr->[$x]);
    $sim += $ll[$x] * scalar grep {$_ == $ll[$x]} @$sr;
  }
  print "Distance: $sum\tSimilarity: $sim";
}

($ll[$.-1], $rl[$.-1]) = @F;
