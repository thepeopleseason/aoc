#!/usr/bin/perl -nl

BEGIN { ($h,$d,$a) = (0,0,0); }
END { print $h*$d }

if ($_ =~ m/^(\w+) (\d+)$/) {
  if ($1 eq "forward") {
    $h += $2;
    $d += $a*$2;
  }
  $a += $2 if $1 eq "down";
  $a -= $2 if $1 eq "up";
}
