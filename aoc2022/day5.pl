#!/usr/bin/perl -l

my %stacks = ();
my $process = 0;
my $part = 2;

while (<>) {
  chomp $_;
  my $line = $_;

  $process++ if ($_ =~ m/^ 1   2   3 /);
  if ($process == 0) {
    for my $x (1..9) {
      $line =~ s/^((\[[A-Z]\]|\s{3}) ?)//;
      if ($1 !~ m/\s{3}/) {
        push @{$stacks{$x}}, $1;
      }
    }
  }
  else {
    $line =~ m/^move (\d+) from (\d) to (\d)/;
    my ($count, $src, $dest) = ($1, $2, $3);
    my @tmp;
    for my $x (1..$count) {
      if ($part == 2) {
        push @tmp, shift @{$stacks{$src}}; #part2
      }
      else {
        unshift @{$stacks{$dest}}, shift @{$stacks{$src}};
      }
    }
    if ($part == 2) {
      unshift @{$stacks{$dest}}, @tmp; #part2
    }
  }
}

for my $x (1..9) {
  my $crate = ${$stacks{$x}}[0];
  $crate =~ s/\[([A-Z])\]\s*/\1/;
  $result .= $crate;
}
print $result;
