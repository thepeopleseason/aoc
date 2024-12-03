#!/usr/bin/perl -nl -0777 -F/don\'t\(\)/

END {
  foreach (@F) {
    $sum += process_mult_array(
      [split(/mul/, $_ eq $F[0] ? $_ : [split(m/do\(\)/, $_, 2)]->[1] )]);
  }
  print $sum;
}

sub process_mult_array {
  my ($list) = @_;
  my $sum = 0;
  foreach (@$list) {
    $sum += $2 * $3 if (m/^(\((\d{1,3}),(\d{1,3})\))/);
  }
  return $sum;
}
