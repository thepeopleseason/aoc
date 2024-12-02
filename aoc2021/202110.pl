#!/usr/bin/perl -nl

use Data::Dumper;

BEGIN {
  %convert = ( ')' => '(',
               '}' => '{',
               ']' => '[',
               '>' => '<', );
  %product = ( ')' => 3,
               '}' => 57,
               ']' => 1197,
               '>' => 25137, );
  $sum = 0;
}
END { print $sum; }

chomp($_);

my @input = split(//, $_);
my @stack = ();
my $prev = '';
for my $char (@input) {
  if ($char =~ m/[\{\(\[\<]/) {
    push @stack, $char;
    $prev = $char;
  }
  else {
    print join('',@stack);
    if ($convert{$char} eq $stack[$#stack]) {
      pop @stack;
    }
    else {
      print "$.:$char:$product{$char}:$_";
      $sum += $product{$char};
      last;
    }
  }
}
