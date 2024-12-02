#!/usr/bin/perl -nl

use List::Util qw/min/;
BEGIN { $t = 0, $r = 0 }
END { print "$t\t$r" }

chomp($_);
my ($l, $w, $h) = split (/x/, $_);
$t += 2*$l*$w + 2*$w*$h + 2*$h*$l + min($l*$w, $w*$h, $h*$l);
my @dim = sort {$a <=> $b} ($l, $w, $h);
$r += 2*$dim[0] + 2*$dim[1] + $l*$w*$h;

