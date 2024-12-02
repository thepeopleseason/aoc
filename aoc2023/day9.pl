#!/usr/bin/perl -l

my ($p1, $p2) = (0, 0);
while (<>) {
  my @line = split(/\s+/, $_);
  $p1 += $line[-1] + expand_sequence(\@line, 1);
  $p2 += $line[0] - expand_sequence(\@line);
}
print join("\t", $p1, $p2);

sub get_diff {
  my ($seq) = @_;

  my @df_array;
  for (my $x=0; $x<$#{$seq}; $x++) {
    push @df_array, ${$seq}[$x+1] - ${$seq}[$x];
  }
  return \@df_array;
}

sub expand_sequence {
  my ($seq, $next) = @_;
  $next ||= 0;

  my $df_array = get_diff($seq);
  if (scalar(grep {$_ == 0} @$df_array) == $#{$df_array} + 1) {
    return 0;
  }
  return $next ? ${$df_array}[-1] + expand_sequence($df_array, 1) :
    ${$df_array}[0] - expand_sequence($df_array);
}
