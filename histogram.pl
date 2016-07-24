#!/usr/bin/perl
print "Content-Type: text/html\n\n";

use strict;
use warnings;

sub histogram{
   my $hwm = 0;
   my $values = 0;
   my $workingvalue;

   foreach(@_){
      if($_ > $hwm){$hwm = $_;}
      $values++;
   }
   $workingvalue = $hwm;
   while($workingvalue > 0){
      foreach(@_){
         if($_ >= $workingvalue){print "*";}
         else{print " ";}
      }
      print "\n";
      $workingvalue--;
   }
}


histogram(5,4,3,9,1);
