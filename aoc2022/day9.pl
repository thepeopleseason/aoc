#!/usr/bin/perl -nl

use Data::Dumper;

BEGIN { ($head, $tail) = ([0,0], [0,0]); %seen = { '0_0' => 1 }; }
END {
  print scalar keys %seen;
}

chomp $_;
my $line = $_;
my ($dir, $num) = split(/ /, $line);
my $idx;
$idx = 0 if ($dir =~ /[LR]/);
$idx = 1 if ($dir =~ /[UD]/);

for (1..$num) {
  if ($dir =~ /[LD]/) {
    $head->[$idx]--;
  }
  else {
    $head->[$idx]++;
  }
  do {
    move_tail();
  } until tail_adjacent();
}

sub tail_adjacent {
  if (abs($head->[0] - $tail->[0]) <= 1 &&
      abs($head->[1] - $tail->[1]) <= 1) {
    return 1;
  }
  else {
    return 0;
  }
}

sub move_tail {
  print "MOVE";
  print Dumper($head, $tail);
  print "Cur X:". $tail->[0] .",". $head->[0];
  print "Cur Y:". $tail->[1] .",". $head->[1];
  if ($head->[0] == $tail->[0]) {
    $tail->[1] = ($tail->[1]..$head->[1])[1];
  }
  elsif ($head->[1] == $tail->[1]) {
    $tail->[0] = ($tail->[0]..$head->[0])[1];
  }
  else {
    $tail = [($tail->[0]..$head->[0])[1],
             ($tail->[1]..$head->[1])[1]]
  }
  $seen{join('_', @$tail)} = 1;
}

