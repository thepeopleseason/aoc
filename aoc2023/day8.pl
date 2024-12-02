#!/usr/bin/perl -l

use Data::Dumper;
use Math::Utils qw/ lcm /;

my %map;
my @instructions;
my %s2idx = qw / L 0 R 1 /;

while (<>) {
  next unless m/^[A-Z0-9]/;
  if ($. == 1) {
    chomp $_;
    @instructions = split(//, $_);
    next;
  }

  m/^([A-Z0-9]{3}) = \(([A-Z0-9]{3}), ([A-Z0-9]{3})\)/;
  $map{$1} = [$2, $3];
}

print get_zcount('AAA');

my @counts;
for my $anode (grep { m/..A/ } keys %map) {
  push @counts, get_zcount($anode, 1); # part2
}
print lcm(@counts);

sub get_zcount {
  my ($next, $p2check) = @_;
  my $count = 0;
  COUNT: while(1) {
    for my $step (@instructions) {
      $next = $map{$next}->[$s2idx{$step}];
      $count++;
      if (($p2check && substr($next, -1) eq 'Z') || ($next eq 'ZZZ')) {
        last COUNT;
      }
    }
  }
  return $count;
}
