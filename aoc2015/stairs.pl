#!/usr/bin/perl -l

my $f,$c = (0,0);
while (<>) {
  my @line = split(//,$_);
  for (@line) {
    $c++;
    $f ++ if $_ =~ m/\(/;
    $f -- if $_ =~ m/\)/; 
    last if $f == -1;
  }
  last if $f == -1;
}
print $f,"\t$c";
