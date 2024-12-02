#!/usr/bin/perl -sl

use Data::Dumper;
use List::Util qw/ max /;

my @hands;
my %ranks = qw/ 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 T 10 J 11 Q 12 K 13 A 14 /;
$ranks{J} = 1 if $part2;
my $wins = 0;

while (<>) {
  my ($hand, $bid) = split(/\s+/, $_);
  my @handarr = split(//, $hand);

  # get unique character counts
  my %uniq;
  for my $char (@handarr) {
    $uniq{$char}++;
  }

  my $rank = 1; # default ranking
  if (scalar keys %uniq == 1) { # 5 of a kind
    $rank = 7;
  }
  elsif (scalar keys %uniq == 2) {
    $rank = 6 if max(values %uniq) == 4; # 4 of a kind
    $rank = 5 if max(values %uniq) == 3; # full house
    $rank = 7 if ($part2 && $uniq{J}); # 5 of a kind
  }
  elsif (scalar keys %uniq == 3) {
    if (max(values %uniq) == 3) { # Trips
      $rank = ($part2 && $uniq{J}) ? 6 : 4; # part2: 4 of a kind
    }
    if (max(values %uniq) == 2) {   # 2 pair
      $rank = 3;
      if ($part2 && $uniq{J}) { # 4 of a kind or full house
        $rank = ($uniq{J} == 2) ? 6 : 5;
      }
    }
  }
  elsif (scalar keys %uniq == 4) { # 1 pair
    $rank = ($part2 && $uniq{J}) ? 4 : 2; # part2: Trips
  }
  else {
    $rank = 2 if ($part2 && $uniq{J});
  }

  push @hands, { hand => $hand, rank => $rank, bid => $bid };
}
my $count = $.;
for my $hand (sort sort_hands @hands) {
  $wins += $hand->{bid} * $count--;
}
print $wins;

sub sort_hands {
  if ($a->{rank} == $b->{rank}) {
    my @hand1 = split(//, $a->{hand});
    my @hand2 = split(//, $b->{hand});
    for my $x (0..4) {
      next if ($hand2[$x] eq $hand1[$x]);
      return $ranks{$hand2[$x]} <=> $ranks{$hand1[$x]};
    }
  }
  else {
    return $b->{rank} <=> $a->{rank}
  }
}
