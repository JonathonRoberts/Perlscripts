#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket;

my $socket;
my $serverdata;
my $clientdata;

print "Connected to Telnet2 Server.\n";

while(){
$socket = new IO::Socket::INET (
  PeerHost => '127.0.0.1',
  PeerPort => '7070',
  Proto => 'tcp',
) or die "$!\n";
$serverdata = <$socket>;
$serverdata =~ s/<NEWLINE>/\n/g;
chomp $serverdata;
print $serverdata;
# Send message to server.
($clientdata = <STDIN>);
print $socket "$clientdata";
}

$socket->close();
