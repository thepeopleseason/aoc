#!/usr/bin/perl -l

my @input = split(/,/, <>);

printf "Initial state: %s\n".join(',',@input);
my $prev = 0;
for (my $x=1; $x<=256; $x++) {
  @zeroes = grep { $_ == 0 } @input;
  @newinput = map { ($_-1) >= 0 ? $_-1 : 6 } @input;
  for (@zeroes) {
    push @newinput, 8;
  }
  @input = @newinput;
  #printf "After %02d days: %s\n", $x, join(',',@input);
  printf "%d: %d, %d\n", $x, $#input+1, $#input + 1 - $prev;
  $prev = $#input + 1;
}

print $#input + 1;
