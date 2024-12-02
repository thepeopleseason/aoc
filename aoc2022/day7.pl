#!/usr/bin/perl -nl

BEGIN { my %fs; my $curdir; my @wpath; my $total = 0; my $sum = 0; my @deletes;}
END {
  my $small = 30000000;
  for my $dir (keys %fs) {
    if ($fs{$dir}{sum} <= 100000) {
      $sum += $fs{$dir}{sum};
    }
    if ($fs{$dir}{sum} >= (30000000 - (70000000 - $total))) {
      if ($fs{$dir}{sum} < $small) {
        $small = $fs{$dir}{sum};
      }
    }
  }
  print "Part 1: $sum";
  print "Part 2: $small";

  use Data::Dumper;
  print Dumper(\%fs);
}

chomp $_;
my $line = $_;

next if ($line =~ /^\$ ls$/); # ignore

if ($line =~ /^\$ cd (.*)/) {
  if ($1 eq '..') {
    my $prevdir = pop @wpath;
    my $parent = join('-', @wpath);

    $fs{$parent}{sum} += $fs{$parent.'-'.$prevdir}{sum}; # save child dir sums
  }
  else {
    push @wpath, $1 eq '/' ? 'root' : $1;

    my $dir = join('-', @wpath);
    $fs{$dir}{contents} = [] unless $fs{$dir}{contents};
    $curdir = $dir;
  }
}
if ($line =~ /(\d+|dir)/) {
  push @{$fs{$curdir}{contents}}, $line;
  if ($1 > 0) {
    $fs{$curdir}{sum} += $1;
    $total += $1; #save total filesystem number
  }
}

