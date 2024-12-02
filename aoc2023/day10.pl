#!/usr/bin/perl -sl

use Data::Dumper;
my %valid = (n => qr/[7F\|]/,
             s => qr/[LJ\|]/,
             e => qr/[7J\-]/,
             w => qr/[FL-]/);

my @field;
my $start_r, $start_c;
my %seen;
while (<>) {
  chomp $_;
  my @line = split(//,$_);
  if ($_ =~ /(S)/) {
    $start_r = $. - 1;
    $start_c = $-[0];
  }
  for my $x (0..$#line) {
    if ($line[$x] =~ m/[FL-]/) {
      $line[$x] = '.' if ($x == $#line || $line[$x+1] !~ m/^${valid{e}}$/);
    }
    if ($line[$x] =~ m/[7J-]/) {
      $line[$x] = '.' if ($x==0 || $line[$x-1] !~ m/^${valid{w}}$/);
    }
  }
  $field[$.-1] = \@line;
}

my ($r, $c) = ($start_r, $start_c);
follow_pipe($r, $c);

print Dumper(\%seen);

sub follow_pipe {
  my ($r, $c) = @_;
  my $char = $field[$r]->[$c];

  $seen{join("_", $r, $c)} = 1;

  print join("\t", $r, $c, $char);

  if ($char =~ m/[LJ\|]/ || $char eq 'S') {
    if ($field[$r-1]->[$c] =~ m/^${valid{n}}$/) {
      if (!$seen{join("_", $r-1, $c)}) {
        follow_pipe($r-1, $c);
      }
    }
    elsif (($char eq 'L') && ($field[$r]->[$c+1] =~ m/^${valid{e}}$/)) {
      if (!$seen{join("_", $r, $c+1)}) {
        follow_pipe($r, $c+1);
      }
    }
    elsif (($char eq 'J') && ($field[$r]->[$c-1] =~ m/^${valid{w}}$/)) {
      if (!$seen{join("_", $r, $c-1)}) {
        follow_pipe($r, $c-1);
      }
    }
    elsif (($char eq '|') && ($field[$r+1]->[$c] =~ m/^${valid{s}}$/)) {
      if (!$seen{join("_", $r+1, $c)}) {
        follow_pipe($r+1, $c);
      }
    }
  }
  elsif ($char =~ m/[F7]/ || $char eq 'S') {
    if ($field[$r+1]->[$c] =~ m/^${valid{s}}$/) {
      if (!$seen{join("_", $r+1, $c)}) {
        follow_pipe($r+1, $c);
      }
    }
    elsif (($char eq 'F') && ($field[$r]->[$c+1] =~ m/^${valid{e}}$/)) {
      if (!$seen{join("_", $r, $c+1)}) {
        follow_pipe($r, $c+1);
      }
    }
    elsif (($char eq '7') && ($field[$r]->[$c-1] =~ m/^${valid{w}}$/)) {
      if (!$seen{join("_", $r, $c-1)}) {
        follow_pipe($r, $c-1);
      }
    }
  }
  elsif (($char eq '-') && ($field[$r+1]->[$c] =~ m/^${valid{s}}$/)) {
    if (!$seen{join("_", $r, $c-1)}) {
      follow_pipe($r, $c-1);
    }
    elsif (!$seen{join("_", $r, $c+1)}) {
      follow_pipe($r, $c+1);
    }
  }
}
# clean_field();
# clean_field();
# clean_field();
# clean_field();


sub clean_field {
  for (my $x=0; $x<=$#field; $x++) {
    for (my $y=0; $y<=$#{$field[$x]}; $y++) {
      if ($field[$x]->[$y] =~ m/[LJ\|]/) {
        $field[$x]->[$y] = '.' if ($x == 0 || $field[$x-1]->[$y] !~ m/^${valid{n}}$/);
      }
      if ($field[$x]->[$y] =~ m/[F7\|]/) {
        $field[$x]->[$y] = '.' if ($x == $#field || $field[$x+1]->[$y] !~ m/^${valid{s}}$/);
      }
      if ($field[$x]->[$y] =~ m/[FL-]/) {
        $field[$x]->[$y] = '.' if ($x == $#{$field[$x]} || $field[$x]->[$y+1] !~ m/^${valid{e}}$/);
      }
      if ($field[$x]->[$y] =~ m/[7J-]/) {
        $field[$x]->[$y] = '.' if ($y==0 || $field[$x]->[$y-1] !~ m/^${valid{w}}$/);
      }
      $pipecount++ if ($field[$x]->[$y] !~ m/[S\.]/);
    }
    print join('', @{$field[$x]});
  }
}

