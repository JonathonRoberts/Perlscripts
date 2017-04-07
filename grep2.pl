#!/usr/bin/perl
print "Content-Type: text/html\n\n";

#simple, no limits grep

use strict;
use warnings;

my $option;
my $dir;
my $query;
my $lineno;
my $cwd;

if(not defined $ARGV[0]){
   print("Format is >grep2 [-i] <query> <directory>\n");
   exit;
}
elsif(not defined $ARGV[1]){
   print("Format is >grep2 [-i] <query> <directory>\n");
   exit;
}
elsif(defined($ARGV[2])){
   $ARGV[0] =~ s/[^A-Za-z]//;
   $option = $ARGV[0];
   $query = $ARGV[1];
   $dir = $ARGV[2];
}
else{
   $query = $ARGV[0];
   $dir = $ARGV[1];
}

if($dir eq "."){
   $dir = "./";
}

if(not defined $option){
   foreach(glob($dir . "*")){
      open FILE, "$dir$_";
      $cwd = $_;
      $lineno = 1;
      while(<FILE>){
         if(/$query/g){
         print "$cwd, line $lineno. Found $query\n";
         $lineno++;
         }
      }
      close FILE;
   }
}
elsif($option eq "i"){
   foreach(glob($dir . "*")){
      open FILE, "$dir$_";
      $cwd = $_;
      $lineno = 1;
      while(<FILE>){
         if(/$query/ig){
         print "$cwd, line $lineno. Found $query\n";
         $lineno++;
         }
      }
      close FILE;
   }
}
else{
   print "Format is >grep2 [-i] <query> <directory>";
}
