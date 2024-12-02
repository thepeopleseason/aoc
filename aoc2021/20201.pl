#!/usr/bin/perl -l

chomp(my @lines = <>);

for (my $x=0; $x<=$#lines; $x++) {
  for (my $y=$x+1; $y<=$#lines; $y++) {
    for (my $z=$y+1; $z<=$#lines; $z++) {
      if ($lines[$x] + $lines[$y] + $lines[$z] == 2020) {
        print $lines[$x]*$lines[$y]*$lines[$z];
        last;
      }
    }
  }
}
