#!/usr/bin/perl -l

use Data::Dumper;

chomp(my @lines = <>);

print &process_lines(\@lines, "", "least", 0);

sub process_lines {
  my ($lines, $result, $type, $call) = @_;

  if ($#$lines == 0) {
    return $$lines[0][$call..11];
  }
  my @cols;

  print Dumper ($lines);
  for my $line (@$lines) {
    my @bits = split(//, $line);
    for (my $x=0; $x<=$#bits; $x++) {
      push @{$cols[$x]}, $bits[$x];
    }
  }

  return '' if $call > $#cols+1;
  my $count0 = grep { $_ == 0 } @{$cols[$call]};
  my $count1 = grep { $_ == 1 } @{$cols[$call]};
  $call++;

  if ($count1 > $count0) {
    $most = 1;
    $least = 0;
  }
  elsif ($count0 > $count1) {
    $most = 0;
    $least = 1;
  }
  else {
    if ($type eq "most") {
      $most = 1;
      $least = 0;
    }
    else {
      $most = 0;
      $least = 1;
    }
  }

  if ($type eq "least") {
    $result .= $least;
    my @filtered = grep { $_ =~ m/^\Q$result\E/ } @$lines;
    print $#filtered;
    print $result;
    return $result . &process_lines(\@filtered, $result, $type, $call);
  }
}

