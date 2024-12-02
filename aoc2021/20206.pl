#!/usr/bin/perl -nl

use List::MoreUtils qw(uniq);

BEGIN { $count = 0; $accum = ''; @groups = () }
END {
  push @groups, $accum;
  for my $group (@groups) {
    print $group, "***";
    my @groupq = split(/-/,$group);
    
    $count += scalar(@groupq);
  }
  print $count;
}

if (m/^\s*$/) {
  push @groups, $accum;
  $accum = '';
}
$accum .= '-' . $_;

