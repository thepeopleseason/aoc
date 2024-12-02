#!/usr/bin/perl -nl

use Data::Dumper;

BEGIN {$count=0};
END {print $count};

my ($input, $output) = split(/ \| /, $_);
#$count += scalar(grep {$_ =~ m/^(.{2}|.{3}|.{4}|.{7})$/} split(/\s/, $output))

my %digits;
my @inputs = split(/ /,$input);
my %elements;
for my $in (sort { length($a) <=> length($b) } @inputs) {
  my $len = length($in);
  my $elems = [split(//, $in)];
  if ($len == 2) {
    $digits{&sortstr($in)} = 1;
    $elements{1} = $elems;
  }
  elsif ($len == 3) {
    $digits{&sortstr($in)} = 7;
    $elements{7} = $elems;
  }
  elsif ($len == 4) {
    $digits{&sortstr($in)} = 4;
    $elements{4} = $elems;
  }
  elsif ($len == 7) {
    $digits{&sortstr($in)} = 8;
  }
  elsif ($len == 5) {
    #2, 3, 5
    if (($elements{1} && &match($in, $elements{1}))
        || ($elements{7} && &match($in, $elements{7}))) {
      $digits{&sortstr($in)} = 3;
    }
    else {
      if (&isectct($elems, $elements{4}) == 2)  {
        $digits{&sortstr($in)} = 2;
      }
      else {
        $digits{&sortstr($in)} = 5;
      }
    }
  }
  elsif ($len == 6) {
    #0, 6, 9
    if (&match($in, $elements{4})) {
      $digits{&sortstr($in)} = 9;
    }
    elsif (&match($in, $elements{7})) {
      $digits{&sortstr($in)} = 0;
    }
    else {
      $digits{&sortstr($in)} = 6;
    }
  }
}

my $num = '';
for my $out (split(/ /, $output)) {
  $num .= $digits{&sortstr($out)};
}
print $num;
$count += $num;

sub match {
  my ($input, $elem_array) = @_;
  my @elems = split(//, $input);

  my $matchct = 0;
  for my $char (@elems) {
    $matchct++ if (grep { $_ eq $char } @$elem_array);
  }
  return true if $matchct == scalar(@$elem_array);
}

sub sortstr {
  my ($input) = @_;
  return join('', sort split(//, $input));
}

sub isectct {
  my ($a1, $a2) = @_;
  my (%union, %isect);

  foreach $e (@$a1, @$a2) {
    $union{$e}++ && $isect{$e}++
  }
  @isect = keys %isect;
  return scalar(@isect);
}
