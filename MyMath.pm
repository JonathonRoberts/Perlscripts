#!/usr/bin/perl
print "Content-Type: text/html\n\n";

use strict;
use warnings;
use Exporter qw (import);
our @Export_ok = qw (listprimesupto);
package MyMath;

sub listprimesupto{
   my $x = 5;
   my $y;
   my $factor;
   my @primes = (2,3);

   while($#primes +2 < $_[0]){
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
   return @primes;
}
