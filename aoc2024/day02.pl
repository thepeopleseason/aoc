#!/usr/bin/perl -n -F/\s/

use Data::Dumper;

BEGIN {
  my @levels;
  my $safe;
}

END {
  print $safe,"\n";
}

my @line = @F;
$safe++ if check_line_safe(\@line);

sub check_line_safe {
  my ($line, $damper) = @_;
  my $dec = 'false';

  if ($line->[0] < $line->[1] && $line->[$#$line-1] <= $line->[$#$line]) {
    $dec = 0; #increasing
  }
  elsif ($line->[0] > $line->[1] && $line->[$#$line-1] >= $line->[$#$line]) {
    $dec = 1; #decreasing
  }
  else {
    # first two levels in line are equal or not reconciling with last two levels
    return !$damper ?
      check_line_safe([@$line[1..$#$line]], 1) || check_line_safe([@$line[0..$#$line-1]], 1)
      : 0;
  }

  for (my $x=0; $x<$#$line; $x++) {
    my $diff = $line->[$x+1] - $line->[$x];

    if (abs($diff) > 3) {
      return !$damper ?
        check_line_safe($x ? [@$line[0..$x,$x+2..$#$line]] : [@$line[$x+2..$#$line]], 1) ||
        check_line_safe([@$line[0..$x-1,$x+2..$#$line]], 1)
        : 0;
    }
    elsif ($dec == 1 && $diff >= 0) {
      return !$damper ?
        check_line_safe($x ? [@$line[0..$x,$x+2..$#$line]] : [@$line[$x+2..$#$line]], 1)
        : 0;
    }
    elsif ($dec == 0 && $diff <= 0) {
      return !$damper ?
        check_line_safe($x ? [@$line[0..$x,$x+2..$#$line]] : [@$line[$x+2..$#$line]], 1)
        : 0;
    }
  }
  return 1;
}
