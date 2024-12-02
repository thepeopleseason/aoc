#!/usr/bin/perl -s

use Data::Dumper;

%races;
while (<>) {
  $_ =~ /^(.*):\s+(\d+)\s+(\d+)\s+(\d+)(\s+(\d+))?/;
  $races{lc($1)} = $part2 ? [$2.$3.$4.$6] : [$2,$3,$4,$6]
}

my $score = 1;
for (my $x=0; $x<=$#{$races{time}}; $x++) {
  next unless ($races{time}->[$x]);
  $races{wins}->[$x] = 0;
  for my $y (0..$races{time}->[$x]) {
    if (($races{time}->[$x]-$y) * $y > $races{distance}->[$x]) {
      $races{wins}->[$x]++;
    }
  }
  $score *= $races{wins}->[$x];
}
print $score,"\n";
