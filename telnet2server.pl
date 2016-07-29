#!/usr/bin/perl
print "Content-Type: text/html\n\n";

use strict;
use warnings;
use Cwd;
use IO::Socket;
use Net::Domain qw(hostname hostfqdn hostdomain);

IO::Socket->input_record_separator('\n');

my $socket = new IO::Socket::INET(
   LocalPort =>"7070",
   LocalHost =>'localhost',
   Proto =>"tcp",
   Listen => 1,
   Reuse => 1,
);
die "Could not create socket$!\n" unless $socket;

#network variables
my $clientsocket;
my $serverdata;
my $clientdata;
#prompt variables
my $dir = cwd;
my @pwdfiles = glob($dir . "/*");
my $username = $ENV{'LOGNAME'};
my $PS1 =$ENV{'PS1'};
#my $hostname = hostname();
my $hostname = hostname();
my $prompt;
my $promptdir;
promptgen();
#other variables
my $motd = "Velkomen" . "<NEWLINE>$prompt";

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

