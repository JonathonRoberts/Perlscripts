#!/usr/bin/perl
print "Content-Type: text/html\n\n";

#Limitation, can only filter the first page of a public wishlist

use strict;
use warnings;
use LWP::Simple qw(get);

my $url = 'https://www.amazon.co.uk/gp/registry/wishlist/oeuaoeuaoeu/';
my $html = get $url;

my @page = split /\n/, $html;
my $bookname;

foreach(@page){
   if(/(<a class="a-link-normal a-declarative" title=")(.*)" href/){
      $bookname = $2;
   }
   if(/(\s{24}.?)(\d*.\d*)$/){
      if($2<2){
         print "New @ $2 $bookname\n";
      }
   }
   if(/(from <span class=\"a-color-price itemUsedAndNewPrice\">).?(.*)</){
      if($2<2){
         print "Used @ $2 $bookname \n";
      }
   }
}
