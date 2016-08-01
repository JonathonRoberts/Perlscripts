#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket;
use IO::Prompter;
use Term::ReadKey;

my $socket;
my $serverdata;
my $clientdata;
my $host = 'localhost';
my $port = 7070;
my $chosenport = 0;

#Options
if(defined($ARGV[0]) && $ARGV[0] eq "-p"){
   if(defined($ARGV[1]) && int($ARGV[1])){
      $port = $ARGV[1];
   }else{
      print "$ARGV[1] is not a valid port number!\n";
   }
   $chosenport = 1;
}
if($chosenport == 1){
   if(defined $ARGV[2]){
      $host = $ARGV[2];}
}else{
   if(defined $ARGV[0]){
      $host = $ARGV[0];}
}
for(my $i = 0; $i<10; $i++){
   if(defined($ARGV[$i]) && $ARGV[$i] eq "-h"){
      print "\nUsage: telnet2client.pl -p [port] [host]\n       -h for help\n\n";
      exit;
   }
}


#Main
print "Connected to Telnet2 Server.\n";

while(){
$socket = new IO::Socket::INET (
  PeerHost => $host,
  PeerPort => $port,
  Proto => 'tcp',
) or die "$!\n";
$serverdata = <$socket>;
$serverdata =~ s/<NEWLINE>/\n/g;
chomp $serverdata;
print $serverdata;
if($serverdata eq "Telnet2 password:") {
   $clientdata = prompt -prompt=> "",-echo=> "";
}
else{($clientdata = <STDIN>);}
print $socket "$clientdata";
}

$socket->close();
