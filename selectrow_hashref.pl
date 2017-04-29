use strict;
use warnings;
use utf8;
use feature qw(say);

use DBI;


my $dbh = DBI->connect("DBI:mysql:database=test;host=localhost","nobody", "nobody");

my $row;
eval {
    $row = $dbh->selectrow_hashref(q[select * from tst_text_blob]);
};

use Data::Dumper;
warn Dumper $row;


$dbh->disconnect();
