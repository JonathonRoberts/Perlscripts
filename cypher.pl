#!/usr/bin/perl
print "Content-Type: text/html\n\n";

use strict;
use warnings;
use DateTime;

my $time = DateTime->now;
my $tmp = 0;
my %cypher;
my %chosenchars;

print "Name this cypher (optional):";
my $name = <STDIN>;

open(KEY,">>cypher.txt");
print KEY "--------------------------------------\n$time - $name--------------------------------------\n";
foreach(33..126){
   until(not defined $chosenchars{$tmp}){$tmp = int(33+rand(127-33));}
   $chosenchars{$tmp}++;
   $cypher{chr($_)} = chr($tmp);
   print KEY chr($_) . " = " . chr($tmp) . "\n";
}
close KEY;
print "Enter text to cypher:\n";
while(<STDIN>){
   foreach(split("", $_)){

      print $cypher{$_} if $cypher{$_};
   }
   print "\n";
}
