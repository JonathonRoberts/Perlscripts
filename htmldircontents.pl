#!/usr/bin/perl
print "Content-Type: text/html\n\n";

use strict;
use warnings;
use Cwd;
my $directory;
my @files;

if(not defined($ARGV[0])){
   $directory = getcwd;
   @files = glob("./*");
}
else{
   $directory = $ARGV[0];
   @files = glob($directory . "/*");
}


print "<title>Table of Contents for $directory</title>\n";
foreach( @files){
   print "<a href=\"$_\">$_</a><br>\n";
}
