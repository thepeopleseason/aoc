#!/usr/bin/perl -nl -0777 -F/don\'t\(\)/

END {
  for my $token (@F) {
    if ($token eq $F[0]) {
      $sum += process_mult_array([split(/mul/, $token)]);
    }
    else {
      next unless $token =~ m/do\(\)/;
      $sum += process_mult_array(
        [split(/mul/,
               [split(m/do\(\)/, $token, 2)]->[1])]);
    }
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
