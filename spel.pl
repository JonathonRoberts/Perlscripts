#!/usr/bin/perl
print "Content-Type: text/html\n\n";

use strict;
use warnings;

open DICT, '/usr/share/dict/words' or die;
open FILE, "@ARGV" or die "File not found!\n";
my $dict = <DICT>;
my @dict = split /\s+/, $dict;
my $word;

my %dict;
foreach(@dict){
   s/[^A-Za-z]//;
   $dict{$_} = 1;
}

print "Mis-spelt words:\n";
while(<FILE>){
   for $word (split){
      unless($dict{$word}){print $word . "\n";}
   }
}
