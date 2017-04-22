use strict;
use warnings;

use feature qw(say);

use List::MoreUtils qw(any);

my @entries = (
    {eid => 1, page => 1},
    {eid => 2, page => 1},
    {eid => 3, page => 1},
    {eid => 4, page => 1},
    {eid => 5, page => 1},
);
my $alive_eid = [1,2,4];


my $alive_entries = [grep {
    my $eid = $_->{eid};
    any {$eid == $_} @$alive_eid;
} @entries];


use Data::Dumper;
warn Dumper $alive_entries;
