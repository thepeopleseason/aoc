#!/usr/bin/perl
 
use strict;
use warnings;
 
my $input = <>;
 
my $part1;
my $part2;
 
for (my $i = 0; !defined($part2); $i++) {
    $part1 //= $i +  4 if (substr($input, $i,  4) !~ m#(\w).*\1#);
    $part2 //= $i + 14 if (substr($input, $i, 14) !~ m#(\w).*\1#);
}
 
print "Part 1: $part1\n";
print "Part 2: $part2\n";
