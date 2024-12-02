#!/usr/bin/perl -l

my @dirs = split(/, /, <>);

my ($h, $v, $o) = (0, 0, 'n');

for my $inst (@dirs) {
  my ($dr, $ds) = split(//, $inst);
  ($h, $v, $o) = &move($h, $v, $o, $dr, $ds);
}
print $h + $v;

sub move() {
  my ($h, $v, $o, $dir, $dist) = @_;


  if ($o eq 'n') {
    $no = 'w' if ($dir eq 'L');
    $no = 'e' if ($dir eq 'R');
  }
  elsif ($o eq 's') {
    $no = 'e' if ($dir eq 'L');
    $no = 'w' if ($dir eq 'R');
  }
  elsif ($o eq 'w') {
    $no = 's' if ($dir eq 'L');
    $no = 'n' if ($dir eq 'R');
  }
  elsif ($o eq 'e') {
    $no = 'n' if ($dir eq 'L');
    $no = 's' if ($dir eq 'R');
  }

  if ($no eq 'n') {
    $v += $dist;
  }
  elsif ($no eq 's') {
    $v -= $dist;
  }
  elsif ($no eq 'e') {
    $h += $dist;
  }
  else {
    $h -= $dist;
  }
  print "$dir$dist: $h, $v, $o, $no, $dir, $dist";
  return ($h, $v, $no);
}
