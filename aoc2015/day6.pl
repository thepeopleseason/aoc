#!/usr/bin/perl -nl

BEGIN { @grid = (0,0) x 1000; }

chomp $_;
my $line = $_;
$line =~ /(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/;

if ($1 eq "turn on") {
  $grid
}
