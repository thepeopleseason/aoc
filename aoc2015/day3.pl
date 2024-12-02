#!/usr/bin/perl -p

use Data::Dumper;

my %pos = qw/ x 0 y 0/;
my %rpos = qw/ x 0 y 0/;
my %travels = ();
$travels{textify_coords(\%pos)} = 1;
$travels{textify_coords(\%rpos)} = 1;

chomp($_);
my @directions = split(//,$_);
for (my $x=0; $x < $#directions; $x++) {
  my $dir = $directions[$x];
  if ($x%2) {
    if ($dir eq '^') {
      $pos{y}++;
    }
    elsif ($dir eq 'v') {
      $pos{y}--;
    }
    elsif ($dir eq '>') {
      $pos{x}++;
    }
    elsif ($dir eq '<') {
      $pos{x}--;
    }
    $travels{textify_coords(\%pos)}++;
  }
  else {
    if ($dir eq '^') {
      $rpos{y}++;
    }
    elsif ($dir eq 'v') {
      $rpos{y}--;
    }
    elsif ($dir eq '>') {
      $rpos{x}++;
    }
    elsif ($dir eq '<') {
      $rpos{x}--;
    }
    $travels{textify_coords(\%rpos)}++;
  }
}

print scalar keys %travels;

sub textify_coords {
  my ($coord) = @_;
  return $coord->{x}."-".$coord->{y};
}
