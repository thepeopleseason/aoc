#!/usr/bin/perl -nl

BEGIN { my $count=0; my @elves; my $max=0; }
END {
  print $elves[$max];
  my $top3 = 0;
  foreach ((sort {$b <=> $a} @elves)[0..2]) {
    $top3 += $_;
  }
  print $top3;
}
if ($_ =~ /^$/) {
  $max = $count if $elves[$count] > $elves[$max];
  $count++;
  next;
}
$elves[$count] += $_;



