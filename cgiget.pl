#!/usr/bin/perl
print "Content-Type: text/html\n\n";
use strict;
use warnings;

my $buffer;
my $name;
my $pair;
my $value;
my @pairs;
my %query;

$buffer = $ENV{'QUERY_STRING'};
@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
   ($name,$value) = split(/=/, $pair);
   $value =~ tr/+/ /;
   $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
   $value =~ s/~!/ ~!/g;
   $query{$name} = $value;
}

