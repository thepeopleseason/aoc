#!/usr/bin/perl -sl

use Data::Dumper;
use List::Util qw/max min/;

my @patterns;
my @patternbuf = ();
my $pattern_count = 1;

while (<>) {
  chomp $_;

  if ($_ =~ m/^\s*$/ || eof()) {
    push @patterns, [@patternbuf];
    @patternbuf = ();
  }
  else {
    push @patternbuf, $_;
  }
}

my $sum = 0;
my $smudge_sum = 0;
for my $x (0..$#patterns) {
  my $pattern = $patterns[$x];
  my ($check, $smudge) = check_pattern($pattern);

  $sum += $check * 100;
  $smudge_sum += $smudge * 100;

  ($check, $smudge) = check_pattern(transpose($pattern));

  $sum += $check;
  $smudge_sum += $smudge;
}
print join("\t", $sum, $smudge_sum);

sub check_pattern {
  my ($pattern) = @_;
  my $prev = '';

  my %indices;
  my %smudges;
  for my $x (0..$#$pattern) {
    if (($x > 0 && $pattern->[$x] eq $prev) || length(strdiff($prev, $pattern[$x])) == 1) {
      my ($check, $smudge) = check_mirroring($pattern, $x);
      $indices{$check} = $x if ($check);
      $smudges{$smudge} = $x if ($smudge);
    }
    else {
      $prev = $pattern->[$x];
    }
  }
  return ($indices{max(keys %indices)}||0, $smudges{min(keys %smudges)}||0)
}

sub check_mirroring {
  my ($pattern, $index) = @_;

  my ($count, $smudge) = (0, 0);
  if ($index == 1) {
    return $index;
  }
  else {
    my $length = ($index > $#$pattern/2) ? $#$pattern - $index : $index - 1;
    my @front = reverse @$pattern[$index-1-$length..$index-1];
    my @back = @$pattern[$index..$index+$length];

    for my $x (0..$#front) {
      $count++ if $front[$x] eq $back[$x];
      if ($front[$x] ne $back[$x]) {
        if (length(strdiff($front[$x], $back[$x])) == 1) {
          $smudge++;
        }
        $count = 0;
        last;
      }
    }
  }
  return ($count, $smudge);
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

sub strdiff {
  my ($s1, $s2) = @_;
  my @s1 = split //, $s1;
  my @s2 = split //, $s2;
  my $return;
  for my $x (0..$#s1) {
    next if $s1[$x] eq $s2[$x];
    $return .= $s1[$x];
  }
  return $return;
}
