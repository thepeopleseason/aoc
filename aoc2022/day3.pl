#!/usr/bin/perl -nl

use Data::Dumper;
BEGIN {
  %pri;
  @pri{(a..z)} = (1..26);
  @pri{(A..Z)} = (27..52);
  $result1 = 0;
  $result2 = 0;
}
END {
  print $result1;
  print $result2;
}

chomp $_;
my $line = $_;
my ($first, $second) = (substr($line, 0, length($line)/2), substr($line, length($line)/2, length($line)));
$result1 += $pri{incommon($first, $second)};

push @group, $line;
if ($#group == 2) {
  $result2 += $pri{incommon(incommon($group[0], $group[1]), $group[2])};
  undef @group;
}


sub incommon {
  my ($str1, $str2) = @_;
  (my $common = reverse $str2) =~ s/[^$str1]|(.)(?=.*\1)//g;

  return scalar reverse $common;
}

