use strict;
use warnings;
use utf8;

use Encode qw(decode_utf8 encode_utf8);
use DBI;

my $dbh = DBI->connect("DBI:mysql:database=test;host=localhost","nobody", "nobody");

$dbh->{mysql_enable_utf8} = 1;

my $text1 = "道後"; # => 内部表現
$dbh->do(q[INSERT INTO test_dbd(text) VALUES (?)], undef,$text1);
my $text2 = encode_utf8 "草津"; # => バイト列
$dbh->do(q[INSERT INTO test_dbd(text) VALUES (?)], undef,$text2);

# Disconnect from the database.
$dbh->disconnect();
