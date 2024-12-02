#!/usr/bin/perl -nl

BEGIN { $max = 0; @seats = (0) x 953; }
END {
  print $max;
  for ($x = 0; $x<$#seats; $x++) {
    print $x if $seats[$x] == 0;
  }
}

my @chars = split(//, $_);
my @rows = 0..127;
my @cols = 0..7;
for my $char (@chars) {
  if ($char eq 'B' || $char eq 'F') {
    my @lower = @rows;
    my @upper = splice @lower, scalar(@rows)/2;

    if ($char eq 'B') {
      @rows = @upper;
    }
    elsif ($char eq 'F') {
      @rows = @lower;
    }
  }
  else {
    my @left = @cols;
    my @right = splice @left, scalar(@cols)/2;

    if ($char eq 'L') {
      @cols = @left;
    }
    elsif ($char eq 'R') {
      @cols = @right;
    }
  }
}
my $seat = $rows[0] * 8 + $cols[0];
$seats[$seat] = 1;
print join(' ',$rows[0], $cols[0], );
if (($rows[0] * 8 + $cols[0]) > $max) {
  $max = $rows[0] * 8 + $cols[0];
}
