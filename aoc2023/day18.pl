#!/usr/bin/perl -sl

use Data::Dumper;

my @inst;
my @grid;
my ($currow, $curcol) = (200, 200);
$grid[$currow]->[$curcol] = '#';

while (<>) {
  my ($dir, $mtr, $hex) = split(/\s+/,$_);
  for my $count (1..$mtr) {
    if ($dir eq 'R') {
      $curcol++;
    }
    elsif ($dir eq 'L') {
      $curcol--;
    }
    elsif ($dir eq 'U') {
      $currow--;
    }
    elsif ($dir eq 'D') {
      $currow++;
    }
    $grid[$currow]->[$curcol] = '#';
  }
  push @inst, [split(/\s+/,$_)];
}

for my $row (0..$#grid) {
  print join('', map { $_||'.' } @{$grid[$row]});
}

my $count = 0;
for my $row (0..$#grid) {
  my @holes = split(/(#+)/, join('',map { $_||'.' } @{$grid[$row]}));
  for my $x ($#holes..1) {
    if ($holes[$x] =~ /#/) {
      $count += length($holes[$x]);
    }
    if ($holes[$x] !~ /#+/ && $holes[$x-1] =~ /#/ && $holes[$x+1] =~ /#/) {
      next if (($#holes - x) % 3);
      $holes[$x] = '#' x length($holes[$x]);
      $count += length($holes[$x]);
    }
  }
  print join('', @holes);
  $grid[$row] = [split(//,join('',@holes))];
}

print $count;
