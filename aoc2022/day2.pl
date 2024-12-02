#!/usr/bin/perl -nl

BEGIN { my $score1 = 0; my $score2 = 0}
END {
  print $score1;
  print $score2;
}

my ($elf, $shape) = split(/ /, $_);
$score1 += $shape eq 'X' ? 4 : $shape eq 'Y' ? 8 : 3 if $elf eq 'A';
$score1 += $shape eq 'X' ? 1 : $shape eq 'Y' ? 5 : 9 if $elf eq 'B';
$score1 += $shape eq 'X' ? 7 : $shape eq 'Y' ? 2 : 6 if $elf eq 'C';

$score2 += $shape eq 'X' ? 3 : $shape eq 'Y' ? 4 : 8 if $elf eq 'A'; #rock
$score2 += $shape eq 'X' ? 1 : $shape eq 'Y' ? 5 : 9 if $elf eq 'B'; #paper
$score2 += $shape eq 'X' ? 2 : $shape eq 'Y' ? 6 : 7 if $elf eq 'C'; #scissors


