#!/usr/bin/perl
print "Content-Type: text/html\n\n";

use strict;
use warnings;

my $randn =int(rand(234979));
my $x = 0;
my $word;
my @word;
my @challenge;
my $guess;

open DICT, "/usr/share/dict/words";
while(<DICT>){
   $x++;
   if ($x == $randn){
      $word = $_;
   }
}

$x = 0;
chomp ($word);
foreach(split //, $word){
   push @word, $_;
   push @challenge, "_";
   $x++;
}
#print @word;
print "\n";

my $arrayno = 0;
my $lives = 10;
my $life;
while(){
   $life = 0;
   printf "%2d ",$lives;
   print @challenge;
   print "|";
   chomp($guess = <STDIN>);

   if($guess eq ""){next;} #without this entering a sole enter wins the game
   $arrayno = 0;
   while($arrayno < $x){
      if($word[$arrayno] =~/$guess/i){
         $challenge[$arrayno] = $word[$arrayno];
         $life++;
      }
   $arrayno++;
   }
   if (@word ~~ @challenge){
      print "\n   LIFE\n";
      exit;
   }
   if($life == 0){$lives--;}
   if($lives == 0){
      print "   $word\n\n   DEATH\n";
      exit;
   }
}
