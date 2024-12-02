#!/usr/bin/perl -l

use Digest::MD5 qw(md5_hex);

my $x = -1;
my $hash;
do {
  $x++;
  $hash = md5_hex("bgvyzdsv" . $x);
  print $hash;
} while ($hash !~ m/^00000/);

print $x;
