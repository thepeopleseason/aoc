#!/usr/bin/perl -nl

use List::MoreUtils qw(uniq);

chomp $_;
my $line = $_;
$_ =~ m/(.)(?!\1|\2|\3)(.)(?!\1|\2|\3)(.)(?!\1|\2|\3)(.)(?!\1|\2|\3)/;
print $+[0];

# 14 zero-width negative lookaheads, didn't work, so...

my @split_line = split(//, $line);
for my $x (0..$#split_line) {
  my @list = uniq(@split_line[0+$x..13+$x]);
  print $x+1+$#list.":",@split_line[0+$x..13+$x] if $#list == 13;
}

