#!/usr/bin/perl -nl

BEGIN {$nice = 0}
END {print $nice}

chomp($_);
next if (m/(ab|cd|pq|xy)/);
next unless (m/.*[aeiou].*[aeiou].*[aeiou].*/);
next unless (m/(.)\1/);
$nice++;

