#!/usr/bin/perl -nl -F/mul/
END {
  foreach (@F) {
    $sum += $2 * $3 if (m/^(\((\d{1,3}),(\d{1,3})\))/);
  }
  print $sum;
}
