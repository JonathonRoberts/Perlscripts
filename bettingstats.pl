#!/usr/bin/perl
print "Content-Type: text/html\n\n";
use strict;
use warnings;

#Provides statistics extracted from .csv of matched/arbitrage betting logs
#All commas must be removed from spreadsheet

my $date;
my $bookie;
my $net;
my $NET;
my @values;
my %bookieprofit;
my %dateprofit;

open FILE, $ARGV[0] or die "File not found!\n";
while(<FILE>){
   @values = (split(",", $_));
   if($values[0] eq "Total profit"){next;}
   unless($values[2] eq ""){
      $date = $values[2];
      $date =~ s/\///g;
      $bookie = $values[9];
      $net = $values[10];
      $net =~ s/\?//;
      $bookieprofit{lc($bookie)} += $net;
      $dateprofit{$date} += $net;
      $NET +=$net;
   }
}


for my $key (keys %bookieprofit){
   print "$key $bookieprofit{$key}\n";
}
print "Net profit = $NET\n\n";
exit;
