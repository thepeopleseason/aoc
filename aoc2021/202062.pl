#!/usr/bin/perl -l

use List::MoreUtils qw(uniq);
use Data::Dumper;

BEGIN { $count = 0; $accum = ''; @group = (); }
END { print $count; }

while (<>) {
  if (m/^\s*$/ || eof()) {
    print Dumper(@group);
    if (scalar(@group) == 1) {
      $accum = scalar(split(//,$group[0]));
      print $accum;
    }
    elsif (scalar(@group) == 2) {
      $accum = scalar(@{&get_isect(&get_array($group[0]), &get_array($group[1]))});
      print $accum;
    }
    else {
      my @isect = @{&get_array($group[0])};
      for (my $x=1; $x<=$#group; $x++) {
        @isect = @{&get_isect(\@isect, &get_array($group[$x]))};
      }
      $accum = scalar(@isect);
      print $accum;
    }
    @isect = ();
    $accum = 0;
    @group = ();
  }
  else {
    push @group, $_;
  }
}

sub get_array {
  my ($string) = @_;
  return [split(//, $string)];
}

sub get_isect {
  my ($a, $b) = @_;
  foreach $e (@$a, @$b) {
    $union{$e}++ && $isect{$e}++
  }
  @union = keys %union;
  @isect = keys %isect;
  return \@isect;
}
