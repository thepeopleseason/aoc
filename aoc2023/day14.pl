#!/usr/bin/perl -l

my $sum = 0;
my $mirror = [];
while (<>) {
  chomp $_;
  push @$mirror, $_;
}

my %seen;
for my $x (1..1000) {
  $mirror = just_a_shot_away(transpose($mirror)); # North
  print "Part 1: " . count (transpose($mirror)) if ($x == 1); # part 1
  $mirror = just_a_shot_away(transpose($mirror)); # West
  $mirror = just_a_shot_away(transpose([reverse @$mirror])); # South
  $mirror = just_a_shot_away(transpose([reverse @$mirror])); # East
  $mirror = transpose([reverse @{transpose([reverse @$mirror])}]);
}
print "Part 2: " . count($mirror);

sub count {
  my ($mirror) = @_;

  my $sum = 0;
  for my $row (0..$#$mirror) {
    my $count = scalar grep {/O/} split(//, $mirror->[$row]);
    $sum += $count * (scalar @$mirror - $row);
  }
  return $sum;
}

sub just_a_shot_away { # roll the stones
  my ($mirror) = @_;
  for my $row (0..$#$mirror) {
    my @elements = split(/(#)/, $mirror->[$row]);
    for my $elem (@elements) {
      next if $elem eq '#';
      my $ocount = scalar grep {/O/} split(//, $elem);
      $elem = 'O' x $ocount . '.' x (length($elem) - $ocount);
    }
    $mirror->[$row] = join('', @elements);
  }
  return $mirror;
}

sub transpose {
  my ($pattern) = @_;

  my @lines;
  for my $x (0..$#$pattern) {
    my @line = split(//, $pattern->[$x]);
    my $col = 0;
    for my $letter (@line) {
      $lines[$col] .= $letter;
      $col++;
    }
  }
  return \@lines;
}
