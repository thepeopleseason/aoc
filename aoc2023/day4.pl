#!/usr/bin/perl -n

BEGIN { $sum = 0; @cards; $copies = 0}
END { print "$sum\t$copies\n"; }

m/^Card\s+(\d+):\s+(.+) \|\s+(.+)/;
my ($card, $winners, $haves) = ($1, $2, $3);
my @winners = sort {$a <=> $b} split(/\s+/, $winners);
my @haves = sort {$a <=> $b} split(/\s+/, $haves);

my $cc=0;
for my $have (@haves) {
  next unless $have =~ m/\d+/;
  $cc++ if (grep {$_ == $have} @winners);
}
$result = ($cc==0) ? 0 : (2**($cc-1));
$sum += $result;

for my $copy (0..$cards[$card]) {
  $copies++;
  for my $index (1..$cc) {
    $cards[$card+$index]++;
  }
}
