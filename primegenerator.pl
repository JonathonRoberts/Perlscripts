#!/usr/bin/perl
print "Content-Type: text/html\n\n";

use strict;
use warnings;

my $x = 5;
my $y;
my $factor;
my @primes = (2,3);

while($#primes +2 < 1000){
   $factor = 3;
   until ($x % $factor == 0){
      $y = sqrt($x);
      if ($y < $factor){
            push(@primes, $x);
            $factor = $x -2;
      }
      $factor += 2;
   }
   $x += 2;
}
print $primes[-1];
