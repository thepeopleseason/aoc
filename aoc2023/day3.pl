#!/usr/bin/perl

my @schematic;
my %parts;
my %gears;
my $sum = 0;
my $ratios = 0;

while (<>) {
  chomp $_;

  # save the line
  my @line = split(//,$_);
  $schematic[$.-1] = \@line;

  # get only numbers, then process them
  my @parts = split(/\D+/, $_);

  my %seen = {};
  for my $part (@parts) {
    next unless $part =~ m/(\d+)/;
    if ($seen{$part}) {
      # multiple instances of a number on the line
      $index = index($_, $part, $seen{$part}+1);
      $parts{join('~', $., $part, $index)} = $index;
      $seen{$part} = $index;
    }
    # save line number, part number and index
    $_ =~ m/(^|\D)($part)(\D|$)/;
    $parts{join('~', $., $part, $-[2])} = $-[2];
    $seen{$part} = $-[2];
  }
}

# check each part number
for my $partkey (sort {$a cmp $b} keys %parts) {
  my ($lineno, $part, $index) = split(/~/, $partkey);
  $sum += $part if check_partno($part, $lineno, $index);
}
print "$sum\n";

# find gear ratios for any gear with 2 parts
for my $key (keys %gears) {
  if (scalar @{$gears{$key}} == 2) {
    $ratios += $gears{$key}->[0] * $gears{$key}->[1];
  }
}
print "$ratios\n";

sub check_partno {
  my ($part, $lineno, $index) = @_;
  my $len = length($part);

  my @adjacent;
  my ($start_col, $end_col) = ($index ? $index - 1: $index,
                               $index+$len );

  # current line
  if ($index) {
    push @adjacent, $schematic[$lineno-1]->[$start_col];
    if ($schematic[$lineno-1]->[$start_col] eq '*') {
      save_gear(join('~',$lineno-1, $start_col), $part);
    }
  }
  push @adjacent, $schematic[$lineno-1]->[$end_col];
  if ($schematic[$lineno-1]->[$end_col] eq '*') {
    save_gear(join('~',$lineno-1, $end_col), $part);
  }

  # previous line
  push @adjacent, join('',$schematic[$lineno-2]->@[$start_col..$end_col])
    if ($lineno != 1);

  # next line
  push @adjacent, join('',$schematic[$lineno]->@[$start_col..$end_col])
    if $lineno <= $#schematic;

  for my $x ($start_col..$end_col) {
    for my $y ($lineno-2, $lineno) {
      if ($schematic[$y]->[$x] eq '*') {
        $key = join('~', $y, $x);
        save_gear($key, $part);
      }
    }
  }

  my $adjacent = join('', @adjacent);
  if ($adjacent =~ m/[^\.0-9]/) {
    return 1;
  }
  return 0;
}

sub save_gear {
  my ($key, $part) = @_;
  $gears{$key} = [] unless $gears{$key};
  push @{$gears{$key}}, $part;
}
