#!/usr/bin/perl -nl

BEGIN { my $res1 = 0; my $res2 = 0}
END {
  print $res1;
  print $res2;
}

chomp $_;
my $line = $_;
my @ranges = map { my @ar = split(/-/, $_); ([$ar[0]..$ar[1]]) } split(/,/,$line);

$res1 ++ if subsets($ranges[1], $ranges[0]) or subsets($ranges[0], $ranges[1]);
$res2 ++ if intersects($ranges[0], $ranges[1]);

sub subsets {
    my ($lset, $rset) = @_;
    my %hash;
    undef @hash{@$lset};
    delete @hash{@$rset};
    return !%hash;
}

sub intersects {
  my ($list1, $list2) = @_;
  my %union = %isect = ();

  foreach $e (@$list1, @$list2) {
    $union{$e}++ && $isect{$e}++;
  }
  my @isect = keys %isect;
  return 1 if $#isect >= 0;
}
