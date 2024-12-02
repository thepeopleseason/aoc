#!/usr/bin/perl -nl

use Data::Dumper;

BEGIN { my $res1 = 0; my $res2 = 0}
END {
  print $res1;
  print $res2;
}

chomp $_;
my $line = $_;

my @foo = map { my @ar = split(/-/, $_); ([$ar[0]..$ar[1]]) } split(/,/,$line);

print Dumper(\@foo);

sub setify_lists {
  my ($list1, $list2) = @_;
  my %union = %isect = ();

  foreach $e (@$list1, @$list2) {
    $union{$e}++ && $isect{$e}++;
  }
  my @union = keys %union;
  my @isect = keys %isect;

  return { 'union' => \@union, 'isect' => \@isect };
}
