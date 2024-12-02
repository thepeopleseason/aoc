#!/usr/bin/perl -l

use List::Util qw(sum);

my $sum;
my @lines = split(/,/, <>);
for (@lines) {
  print $_;
  if ($_ =~ m/(-?\d+)/) {
    print $1;
    $sum += $1;
  }
}
print $sum;
