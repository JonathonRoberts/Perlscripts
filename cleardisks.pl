#!/usr/bin/perl

#This script gains some diskspace on Windows 7 machines from input file
#
#>cat /home/jon/input.txt
#Low Disk Space Warning on: PC123456 User connected: THANKS With 1.06GB free space remaining.
#Low Disk Space Warning on: PC654321 User connected: SSTALLONE With 1.08GB free space remaining.
#Low Disk Space Warning on: VM123456 User connected: AHUXLEY With 1.16GB free space remaining.
#
#TODO
#on remote machines run: powercfg /h off
#on windows host this can be done with psexec.exe >powercgf /h off


use strict;
use warnings;
use File::Path;


open(INPUT, '/home/jon/input.txt') or die;


foreach(<INPUT>){
   /.*(\w\w\d{6}).*: (\w+)/;
   &clearmach($1, $2);
}

sub clearmach{

   my $machine = "//$_[0]/C\$";
   my $user = $_[1];
   print "$machine $user\n";
   opendir DIR, "$machine/\$Recycle.Bin/";

   rmtree ("$machine/\$Recycle.Bin"); #Clears Recycle bins for all users
   rmtree ("$machine/MSOCache"); #Deletes MSOCache

   #Delete other users profiles
    opendir DIR, "$machine/Users/";
    my @files = readdir(DIR);
    closedir DIR;
    foreach(@files){
       if(/$user/|| /Default/ || /\./ || /Public/ || /All Users/ || /desktop.ini/ || /Profile/ || /^$user$/i){}
       else{rmtree ("$machine/Users/$_")};
    }

    #Delete Temp files
   opendir DIR, "$machine/Users/$user/Appdata/Local/Temp/";
   @files = readdir(DIR);
   closedir DIR;
   foreach(@files){
      rmtree "$machine/Users/$user/Appdata/Local/Temp/$_";
   }
}

