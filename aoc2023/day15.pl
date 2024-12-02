#!/usr/bin/perl -l

my ($p1, $p2) = (0, 0);
my %boxes;

undef $/;
while(<>) {
  chomp $_;
  $_ =~ s/\n//g;

  for my $op (split(/,/,$_)) {
    $p1 += ascii_hash($op); # part 1

    # part 2
    my ($label, $length) = split(/[=-]/, $op);
    my $box = ascii_hash($label);

    if ($length) {
      push @{$boxes{$box}{order}}, $label unless $boxes{$box}{$label};
      $boxes{$box}{$label} = $length;
    }
    else {
      if ($boxes{$box}{$label}) {
        $boxes{$box}{order} = [grep { $_ ne $label } @{$boxes{$box}{order}}];
        $boxes{$box}{$label} = 0;
      }
    }
  }
}
print $p1;

for my $box (sort {$a <=> $b} keys %boxes) {
  for my $slot (0..$#{$boxes{$box}{order}}) {
    $p2 += ($box + 1) * ($slot+1) * $boxes{$box}{$boxes{$box}{order}[$slot]};
  }
}
print $p2;

sub ascii_hash {
  my ($input) = @_;

  my $val = 0;
  for my $x (split(//, $input)) {
    $val = (ord($x) + $val) * 17 % 256;
  }
  return $val;
}
