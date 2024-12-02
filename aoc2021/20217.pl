#!/usr/bin/perl -l

use List::Util qw(sum);

my @positions = split(/,/, <>);
my $avpos = median(@positions);

print sum map { abs($avpos - $_) } @positions;

$avpos = int(sum(@positions) / scalar(@positions));

print sum map { $n = abs($avpos - $_); $n * ($n+1) / 2 } @positions;

sub median {
  my @sorted = sort { $a <=> $b } @_;
  ($sorted[$#sorted/2 + 0.1] + $sorted[$#sorted/2 + 0.6])/2;
}
