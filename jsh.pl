#!/usr/bin/perl
use strict;
use warnings;
use Cwd;
use Net::Domain qw(hostname hostfqdn hostdomain);

#Simple shell created in perl


#Variables
my $dir = cwd;
my @pwdfiles = glob($dir . "/*");
my $username = $ENV{'LOGNAME'};
my $PS1 =$ENV{'PS1'};
my $hostname = hostname();
my $prompt;
my $promptdir;


sub promptgen{
   $prompt = $PS1;
   $hostname = hostname();
   $promptdir = $dir;
   $promptdir =~ s#/home/$username/#~/#;;
   $prompt =~ s#\\H#$hostname#;
   if($prompt =~ m#\\h#){
      $hostname =~ s/\..+//;
      $prompt =~ s#\\h#$hostname#;
   }
   $prompt =~ s#\\u#$username#;
   $prompt =~ s#\\w#$promptdir#;
   $prompt =~ s#\\W#$dir#;
}

sub nl{
   @pwdfiles = glob($dir . "/*");
   promptgen();
   print $prompt;
}

sub cd {
   if($_[0] =~ m#\s?\.\.#){
      if($dir =~ m#^/$#){
         return;
      } else{
         $dir =~ s#/[^/]*$#/#;
         print $dir;
         chdir($dir);
         return;
      }
   }
   if  ( $_[0] =~ m#^\s?/# ){
      if (-d "/$_[0]"){
      $dir="/$_[0]";
      chdir($dir);
      }
   }
}

nl;

while(<STDIN>){
   chomp($_);
   if ($_ =~ /^cd/){cd($');}
   else {system($_);}
   nl;
}

