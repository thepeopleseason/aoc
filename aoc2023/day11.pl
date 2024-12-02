#!/usr/bin/perl -sl

use Algorithm::Combinatorics qw/ combinations /;

my @skymap;
my %cols;
my $width = 0;
my $growth = $part2 ? 1000000 : 2;

my %expanse;
my @galaxies;

while (<>) {
  chomp $_;
  my $row = $. - 1;
  my @line = split(//, $_);
  push @skymap, \@line;

  # find all filled columns, record galaxies
  my @idx;
  while ($_ =~ m/(\#)/g) {
    push @idx, $-[0];
    push @galaxies, [$row, $-[0]];
  }
  for my $col (@idx) {
    $cols{$col} = 1;
  }

  $width = length($_);

  # find and record all empty rows
  if ($#idx == -1) {
    $expanse{rows}->{$row} = 1;
  }
}

# record all empty columns
for (my $i=0; $i<$width; $i++) {
  $expanse{cols}->{$i} = 1 unless $cols{$i};
}

my $iter = combinations([map { expand_galaxy($_->[0], $_->[1]) } @galaxies], 2);
my $sum = 0;
while (my $pair = $iter->next) {
  $sum += abs($pair->[0]->[0] - $pair->[1]->[0]) +
    abs($pair->[0]->[1] - $pair->[1]->[1]);
}
print $sum;

sub expand_galaxy {
  my ($x, $y) = @_;
  my ($expand_x, $expand_y) = (0, 0);

  for my $col (keys %{$expanse{cols}}) {
    if ($col < $y) {
      $expand_y += ($growth - 1);
    }
  }
  for my $row (keys %{$expanse{rows}}) {
    if ($row < $x) {
      $expand_x += ($growth - 1);
    }
  }
  return [$x + $expand_x, $y + $expand_y];
}
