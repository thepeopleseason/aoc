#!/usr/bin/perl -l -0777 -F/don\'t\(\)/

END {
  foreach (@F) {
    foreach (split(/mul/, $_ eq $F[0] ? $_ : [split(m/do\(\)/, $_, 2)]->[1] )) {
      $sum += $2 * $3 if (m/^(\((\d{1,3}),(\d{1,3})\))/);
    }
  }
  print $sum;
}
