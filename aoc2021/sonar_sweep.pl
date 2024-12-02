#!/usr/bin/perl

use strict;

my $prev;
my $count;
while (<>) {
  unless ($. == 1) {
    $count ++ if $_ > $prev;
  }
  $prev = $_;
}
print $count,"\n";
