#!/usr/bin/perl -l

use Data::Dumper;
use List::Util qw(sum);
my @map = ();

while (<>) {
  chomp($_);
  $map[$.-1] = [split(//, $_)];
}

my @lowpoints;
my @lowcoords;
for (my $x=0; $x<=$#map; $x++) {
  for (my $y=0; $y<=$#{$map[$x]}; $y++) {
    my $height = $map[$x][$y];
    if (($x == 0) && ($y == 0)) {
      if ($map[$x+1][$y] > $height && $map[$x][$y+1] > $height) {
        push @lowpoints, $height;
        push @lowcoords, [$x, $y];
      }
    }
    elsif (($x == 0) && ($y == $#{$map[$x]})) {
      if ($map[$x+1][$y] > $height && $map[$x][$y-1] > $height) {
        push @lowpoints, $height;
        push @lowcoords, [$x, $y];
      }
    }
    elsif (($x == $#map) && ($y == 0)) {
      if ($map[$x-1][$y] > $height && $map[$x][$y+1] > $height) {
        push @lowpoints, $height;
        push @lowcoords, [$x, $y];
      }
    }
    elsif (($x == $#map) && ($y == $#{$map[$x]})) {
      if ($map[$x-1][$y] > $height && $map[$x][$y-1] > $height) {
        push @lowpoints, $height;
        push @lowcoords, [$x, $y];
      }
    }
    elsif ($y == 0) {
      if ($map[$x-1][$y] > $height &&
          $map[$x+1][$y] > $height &&
          $map[$x][$y+1] > $height) {
        push @lowpoints, $height;
        push @lowcoords, [$x, $y];
      }
    }
    elsif ($x == 0) {
      if ($map[$x][$y-1] > $height &&
          $map[$x+1][$y] > $height &&
          $map[$x][$y+1] > $height) {
        push @lowpoints, $height;
        push @lowcoords, [$x, $y];
      }
    }
    elsif ($x == $#map) {
      if ($map[$x-1][$y] > $height &&
          $map[$x][$y-1] > $height &&
          $map[$x][$y+1] > $height) {
        push @lowpoints, $height;
        push @lowcoords, [$x, $y];
      }
    }
    elsif ($y == $#{$map[$x]}) {
      if ($map[$x-1][$y] > $height &&
          $map[$x][$y-1] > $height &&
          $map[$x+1][$y] > $height) {
        push @lowpoints, $height;
        push @lowcoords, [$x, $y];
      }
    }
    else {
      if ($map[$x-1][$y] > $height &&
          $map[$x][$y-1] > $height &&
          $map[$x+1][$y] > $height &&
          $map[$x][$y+1] > $height) {
        push @lowpoints, $height;
        push @lowcoords, [$x, $y];
      }
    }
  }
}

print sum map { $_ += 1 } @lowpoints;

my @basins;
my %viewed;
for my $coord (@lowcoords) {
  my $size = 0;
  my @check;
  push @check, $coord;
  while (scalar(@check)) {
    my $chk = unshift(@check);
    my ($x, $y) = @{$chk};
    next if $map[$x][$y] == 9 || $viewed{$chk};
    if ($map[$x][$y] < 9) {
      $size++;
      $viewed{$chk} = 1;
    }
    my $add;
    if ($x > 0) {
      if ($map[$x-1][$y] < 9) {
        $size++;
        $add = [$x-1, $y];
        $viewed{$add} = 1;
        push @check, $add;
      }
    }
    print Dumper(\@check);
    if ($x < $#map) {
      print "FOO:$x, $y";
      if ($map[$x+1][$y] < 9) {
        $size++;
        $add = [$x+1, $y];
        $viewed{$add} = 1;
        push @check, $add;
      }
    }
    print Dumper(\@check);
    if ($y > 0) {
      if ($map[$x][$y-1] < 9) {
        $size++;
        $add = [$x, $y-1];
        $viewed{$add} = 1;
        push @check, $add;
      }
    }
    print Dumper(\@check);
    if ($y < $#{$map[$x]}) {
      if ($map[$x][$y+1] < 9) {
        $size++;
        $add = [$x, $y+1];
        $viewed{$add} = 1;
        push @check, $add;
      }
    }
    print Dumper(\@check);
    last;
  }
  push @basins, $size;
  print $size;
}

print Dumper(@basins);
