#!/usr/bin/perl

use strict;

chomp(my @lines = <>);

my @windows;
my $prev;
my $count;
for (my $x=0; $x<$#lines; $x++) {
  my $sum = $lines[$x]+$lines[$x+1]+$lines[$x+2];
  push @windows, $sum;
  unless ($x == 0) {
    $count ++ if $sum > $prev;
  }
  $prev = $sum;

}
print $count;

