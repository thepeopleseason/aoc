#!/usr/bin/perl -nl

use Data::Dumper;

BEGIN { @cycles; push @cycles, 1; }
END {
  print 20*$cycles[19] +
    60*$cycles[59] +
    100*$cycles[99] +
    140*$cycles[139] +
    180*$cycles[179] +
    220*$cycles[219];
  &draw_pixels();
}

chomp $_;
my $line = $_;
my $cur = $cycles[-1];
if ($line =~ /addx (-?\d+)/) {
  push @cycles, $cur;
  push @cycles, $cur + $1;
}
elsif ($line =~ /noop/) {
  push @cycles, $cur;
}

sub draw_pixels {
  my $output;
  for my $crt (0..240) {
    my $cur = $crt % 40;
    $output .= ($cycles[$crt] - 1 <= $cur && $cycles[$crt] + 1 >= $cur) ? '#' : '.';
    $output .= "\n" if ($crt > 10 && ($crt+1) % 40 == 0);
  }
  print $output;
}
