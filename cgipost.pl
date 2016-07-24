#!/usr/bin/perl
print "Content-Type: text/html\n\n";
use strict;
use warnings;

my @pairs;
my %FORM;
my $buffer;
my $name;
my $pair;
my $value;

read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
($name, $value) = split(/=/, $pair);
$value =~ tr/+/ /;
$value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
$FORM{$name} = $value;
}
