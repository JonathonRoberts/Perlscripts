#!/usr/bin/perl
print "Content-Type: text/html\n\n";

use strict;
use warnings;

my @input = ("this" ,"is" ,"a test of the", "center", "function");
sub centerfunc{
   my $hwm = 0;
   my $wm = 0;
   my @text = @_;
   my @chars;
   my $count = 0;
   my $chararrayno;

   foreach(@text){   #Find High Water Mark
      $wm = 0;
      foreach(split //,$_){
         $wm++;
      }
      @chars[$chararrayno++] = $wm;
      if($wm > $hwm){$hwm = $wm;}

   }
   $chararrayno = 0;
   foreach(@text){

      $count = 0;
      my $spaces = ($hwm-$chars[$chararrayno])/2 -0.5;

      while( $count < $spaces){
         $text[$chararrayno] = " " . $text[$chararrayno];
         $count++;
      }
   print $text[$chararrayno] . "\n";
         $chararrayno++;
   }
}

centerfunc(@input);
