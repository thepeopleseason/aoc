#!/usr/bin/perl -nl

use Data::Dumper;

BEGIN { my $res1 = 0; my $res2 = 0; my $rows, $columns, @grid;}
END {
  $rows = $.;

  $res1 += $rows * 2 + ($columns - 2) * 2;
  for my $x (1..($rows-2)) {
    for my $y (1..($columns-2)) {
      $res1 ++ if visible($x, $y);
      my $scenic = scenic($x, $y);
      $res2 = $scenic if $scenic > $res2;
    }
  }
  print $res1;
  print $res2;
}

chomp $_;
my @line = split(//, $_);
$columns = $#line + 1;
@grid[$.-1] = \@line;

sub visible {
  my ($x, $y) = @_;
  my $height = $grid[$x][$y];
  my $return = 0;

  my @comp = sort {$b <=> $a} @{$grid[$x]}[0..($y-1)];
  $return = 1 if $comp[0] < $height;

  @comp = sort {$b <=> $a} map { $_->[$y] } @grid[0..($x-1)];
  $return = 1 if $comp[0] < $height;

  @comp = sort {$b <=> $a} @{$grid[$x]}[($y+1)..$columns];
  $return = 1 if $comp[0] < $height;

  @comp = sort {$b <=> $a} map { $_->[$y] } @grid[$x+1..$rows];
  $return = 1 if $comp[0] < $height;

  return $return;
}

sub scenic {
  my ($x, $y) = @_;
  my $height = $grid[$x][$y];
  my $return = 0;

  my ($left, $top, $right, $bottom) = (0,0,0,0);

  for (reverse map { $_->[$y] } @grid[0..($x-1)]) {
    $top++;
    last if ($_ >= $height);
  }

  for (reverse @{$grid[$x]}[0..($y-1)]) {
    $left++;
    last if ($_ >= $height);
  }

  for (map { $_->[$y] } @grid[$x+1..$rows-1]) {
    $bottom++;
    last if ($_ >= $height);
  }

  for (@{$grid[$x]}[($y+1)..$columns-1]) {
    $right++;
    last if ($_ >= $height);
  }

  return $left * $right * $top * $bottom;
}
