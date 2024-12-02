#!/usr/bin/perl -p

BEGIN {
  my $sum = 0;
  $part2 = 0;
  %trans = qw/ one o1e two t2o three t3e four f4r five f5e six s6x seven s7n eight e8t nine n9e /; #thanks to Ray Ashman
}
END {
  print "Result: $sum\n";
}

if ($part2) {
  for my $key (keys %trans) {
    s/$key/$trans{$key}/g;
  }
}
s/\D*//g;
my @digits = split(//,$_);
$sum += $digits[0] . $digits[$#digits];

