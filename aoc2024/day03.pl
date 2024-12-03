#!/usr/bin/perl -nl -F/mul/

use Data::Dumper;

BEGIN { my $sum = 0; }
END {
  for my $token (@F) {
    print "$token";
    if ($token =~ m/^(\((\d{1,3}),(\d{1,3})\))/) {
      my $mult = $2 * $3;
      print "\t$1 : $mult";
      $sum += $mult;
    }
  }
  print $sum;
}
