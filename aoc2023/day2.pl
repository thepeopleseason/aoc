#!/usr/bin/perl -p
#
BEGIN { %limits = qw/ red 12 green 13 blue 14/;
        $sum = 0; $power = 0; }
END { print $sum,"\n"; print $power; }

my ($game, $rounds) = split(/:/, $_);
$game =~ s/^Game (\d+)/\1/;
$sum += $game if (check_game($rounds));
$power += check_power($rounds);

sub check_game {
  my ($rounds) = @_;
  my @pulls = split(/(,|;)/, $rounds);
  for my $pull (@pulls) {
    next unless $pull =~ m/(\d+)\s+(red|green|blue)/i;
    return 0 if ($1 > $limits{$2});
  }
  return 1;
}

sub check_power {
  my ($rounds) = @_;
  my %minims = {};
  my @pulls = split(/(,|;)/, $rounds);
  for my $pull (@pulls) {
    next unless $pull =~ m/(\d+)\s+(red|green|blue)/i;
    $minims{$2} = $1 if $1 > $minims{$2};
  }
  return $minims{red} * $minims{blue} * $minims{green};
}
