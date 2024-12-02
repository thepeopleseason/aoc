#!/usr/bin/perl

use Data::Dumper;
use List::Util qw/ min /;

my @maps;
my @seeds;
my @ranges;

my %loc2range;
process_file();
print get_min_loc(\@seeds),"\n"; # part1

# part2: find the range that generates the lowest location
for my $range (@ranges) {
  next unless $range =~ m/\d+/;

  my ($start, $length) = split(/\s+/, $range);
  my @seeds = map { $start + $_ } (0, $length-1);

  for my $seed (@seeds) {
    $loc2range{$loc} = $range;
  }
}

my ($start, $length) = split(/\s+/, find_low_range($loc2range{min(keys %loc2range)}));
@seeds = map { $start + $_ } (0..$length-1);
print get_min_loc(\@seeds),"\n";

sub process_file {
  my $state = -1;
  my %states = qw/ 0 s2s 1 s2f 2 f2w 3 w2l 4 l2t 5 t2h 6 h2l /;

  # process file
  my @working;
  while (<>) {
    next if /^\s*$/;

    chomp $_;
    if ($_ =~ /seeds:\s+(.*)/) {
      $line = $1;
      @seeds = split(/\s+/, $line);
      @ranges = split(/(\d+\s+\d+)\s+/, $line);
      next;
    }
    elsif ($_ =~ /map:$/ || eof()) {
      push @maps, @working unless $state++ == -1;
      @working = ();
      next;
    }
    else {
      $_ =~ m/^(\d+)\s+(\d+)\s+(\d+)/;
      my ($dest, $src, $range) = ($1, $2, $3);
      push @working, join('~', $states{$state}, $src, $dest, $range);
    }
  }
}

sub get_min_loc {
  my ($seedarray) = @_;
  my @locs;
  for my $seed (@$seedarray) {
    push @locs, get_loc($seed);
  }
  return min(@locs);
}

sub find_low_range {
  my ($range) = @_;

  my ($start, $length) = split(/\s+/, $range);
  if ($length < 50) {
    return $range;
  }

  my ($nstart, $nlength) = ($start, int($length/2));
  my ($loc1, $loc2) = map { get_loc($start + $_) } (0,$length-1);

  if ($loc1 > $loc2) {
    push @seeds, $start;
    $nstart = $start + int($length/2);
  }
  else {
    $nstart = pop(@seeds);
    $nlength = $loc2 - $loc1;
  }
  $nrange = "$nstart $nlength";
  return find_low_range($nrange);
}

sub get_loc {
  my ($seed) = @_;
  $loc = map_check(map_check(
                     map_check(map_check(
                                 map_check(map_check(
                                             map_check($seed, 's2s')
                                             ,'s2f'),'f2w')
                                 ,'w2l'),'l2t')
                     ,'t2h'),'h2l');
  return $loc;
}

sub map_check {
  my ($input, $map) = @_;

  my $result = $input;
  for my $mp (grep {/^$map/} @maps) {
    my ($code, $src, $dest, $range) = split(/~/, $mp);
    if ($input >= $src && $input < $src + $range) {
      $result = $input - $src + $dest;
    }
  }
  return $result;
}
