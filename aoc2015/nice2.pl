#!/usr/bin/perl -nl

BEGIN {$nice = 0}
END {print $nice}

chomp($_);
next unless (m/(..).*\1/);
next unless (m/(.).\1/);
$nice++;

