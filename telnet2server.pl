#!/usr/bin/perl
print "Content-Type: text/html\n\n";

use strict;
use warnings;
use Cwd;
use IO::Socket;
use Net::Domain qw(hostname hostfqdn hostdomain);


#network variables
my $clientsocket;
my $serverdata;
my $clientdata;
#prompt variables
my $dir = cwd;
my @pwdfiles = glob($dir . "/*");
my $username = $ENV{'LOGNAME'};
my $PS1 =$ENV{'PS1'};
my $hostname = hostname();
my $prompt;
my $promptdir;
promptgen();
#Options
my $host = 'localhost';
my $port = 7070;
my $chosenport = 0;
#other variables
my $motd = "Velkomen" . "<NEWLINE>$prompt";
IO::Socket->input_record_separator('\n');

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
      print "\nUsage: telnet2server.pl -p [port] [host]\n       -h for help\n       & to run in background\n\n";
      exit;
   }
}

#Socket
my $socket = new IO::Socket::INET(
   LocalPort =>$port,
   LocalHost =>$host,
   Proto =>"tcp",
   Listen => 1,
   Reuse => 1,
);
die "Could not create socket$!\n" unless $socket;

#Main
loginprompt();
while(){
   $clientsocket = $socket->accept();
   print   "Connected from : ", $clientsocket->peerhost();
   print   ", Port : ", $clientsocket->peerport(), "\n";

   print $clientsocket $serverdata . "\n";
   $clientdata = <$clientsocket>;
   print "Message received from Client : $clientdata\n";

   #setting serverdata
   $serverdata = "";
   $clientdata =~ s/\n$//; #chomp clientdata
   if ($clientdata =~ /^cd/){cd($');}
   elsif($clientdata eq ""){}
   else{$serverdata = `$clientdata`;}
   nl();
}
$socket->close();

#Subroutines
sub loginprompt {
   for(my $open = 0; $open == 0;){
      my $loginuname;
      my $loginpassword;
      $serverdata = "Telnet2 username:";
      $clientsocket = $socket->accept();
      print $clientsocket $serverdata  . "\n";
      $clientdata = <$clientsocket>;
      $clientdata =~ s/\n$//;
      $loginuname = $clientdata;
      $serverdata = "Telnet2 password:";
      $clientsocket = $socket->accept();
      print $clientsocket $serverdata  . "\n";
      $clientdata = <$clientsocket>;
      $clientdata =~ s/\n$//;
      $loginpassword = $clientdata;
      if($loginuname eq "aoeu" && $loginpassword eq "aoeu"){$open = 1; nl();$serverdata = $motd;}
   }
}

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
   $serverdata = "$serverdata$prompt";
   $serverdata =~ s/\n/<NEWLINE>/g;
}

sub cd {
   if($_[0] =~ m#\s?\.\.#){
      if($dir =~ m#^/$#){
         return;
      } else{
         $dir =~ s#/[^/]*$#/#;
         $serverdata = $serverdata . $dir;
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

