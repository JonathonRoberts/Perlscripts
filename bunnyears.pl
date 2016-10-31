#!/usr/bin/perl
print "Content-Type: text/html\n\n";

use strict;
use warnings;

my $n = 9;
my $ans = 0;

&oddbunny;
print $ans . "\n";

sub oddbunny{
   if($n>0){
      $n--;
      $ans+=2;
      &evenbunny;
   }
}
sub evenbunny{
   if($n>0){
      $n--;
      $ans+=3;
      &oddbunny;
   }
}
