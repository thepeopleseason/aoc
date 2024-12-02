#!/usr/bin/perl -l

use Data::Dumper;

my @coords;
while (<>) {
  chomp($_);
  if (m/^fold along (.)/) {
    my $dim = $1;
    for (my $x=0; $x<=$#coords; $x++) {
      if ($dim eq 'x') {
        if ($$dot[0] > $dim) {
          $coords[$x]->[0] -= $dim;
        }
        else {
          $coords[$x]->[1] -= $dim;
        }
      }
      print Dumper($coords[$x]);
    }
  }
  else {
    my ($x, $y) = split(/,/, $_);
    push @coords, [$x, $y];
  }
}
print Dumper(@coords);
