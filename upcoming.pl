#!/usr/bin/perl
print "Content-Type: text/html\n\n";

use strict;
use warnings;
use DateTime;
#Simple calander which takes events from the file ~/.upcoming/events and ~/.upcoming/birthdays
#and displays when they are soon

my $n = 7;
if(defined $ARGV[0] && defined $ARGV[1]){
   if($ARGV[0] eq "-n"&& $ARGV[1] =~/^\d+$/){$n = $ARGV[1];}
}
my $today = DateTime->now;
my $weektoday = $today;
my $evday;
$today =~ s/(....)-(..)-(..)T.+/$1$2$3/;
my $thisday = $3;
my $thismonth = $2;
my $thisyear = $1;


open FILE, "/$ENV{HOME}/.upcoming/events";
print "\nEvents:\n";
showevents(<FILE>);
open FILE, "$ENV{HOME}/.upcoming/birthdays";
print "\nBirthdays\n";
showbirthdays(<FILE>);

sub day{
my $nextday = DateTime->now;
$nextday->add( days => $_[0]);
$nextday =~ s/(....)-(..)-(..)T.+/$1$2$3/;
return $nextday;
}

sub showevents{
   for(my $i = 0; $i<$n; $i++){
      showeventsday($i, @_);
   }
}
sub showeventsday{
   my $i = $_[0];
   foreach(@_){
      if(/^\d+$/){next;}
      $evday = $_;
      $evday =~ s/^(..)(.)(..)(.)(....).+/$5$1$3/;
      $evday =~ s/^(\s+)(.{4})/$thisyear$2/;
      $evday =~ s/^(.{4})(\s\s)(..)/$1$thismonth$3/;
      $evday =~ s/^(.{6})(\s\s)/$1$thisday/;
      if($i==0 && (day($i) == $evday)){print " ===>$_";}
      elsif($i==1 && (day($i) == $evday)){print " --->$_";}
      elsif($i==2 && (day($i) == $evday)){print "  -> $_";}
      elsif($i==3 && (day($i) == $evday)){print "  -> $_";}
      elsif($i==4 && (day($i) == $evday)){print "  -> $_";}
      elsif($i==5 && (day($i) == $evday)){print "   > $_";}
      elsif($i==6 && (day($i) == $evday)){print "   > $_";}
      elsif($i==7 && (day($i) == $evday)){print "     $_";}
      elsif($i>7 && (day($i) == $evday)){print "($i) $_";}
   }
   close FILE;
}
sub showbirthdays{
   for(my $i = 0; $i<$n; $i++){
      showbirthdaydays($i, @_);
   }
}
sub showbirthdaydays{
   my $i = $_[0];
   foreach(@_){
      if(/^\d+$/){next;}
      $evday = $_;
      $evday =~ s/^(..)(.)(..).+/$thisyear$1$3/;
      if($i==0 && (day($i) == $evday)){print " ===>$_";}
      elsif($i==1 && (day($i) == $evday)){print " --->$_";}
      elsif($i==2 && (day($i) == $evday)){print "  -> $_";}
      elsif($i==3 && (day($i) == $evday)){print "  -> $_";}
      elsif($i==4 && (day($i) == $evday)){print "  -> $_";}
      elsif($i==5 && (day($i) == $evday)){print "   > $_";}
      elsif($i==6 && (day($i) == $evday)){print "   > $_";}
      elsif($i==7 && (day($i) == $evday)){print "     $_";}
      elsif($i>7 && (day($i) == $evday)){print "($i) $_";}
   }
   close FILE;
}
