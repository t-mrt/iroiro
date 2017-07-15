use strict;
use warnings;
use utf8;

my $a = [
    {id => 1, v => "a"},
    {id => 2, v => "b"},
    {id => 3, v => "c"},
    {id => 4, v => "d"},
    {id => 5, v => "e"},
];

my $h = {map {
    $_->{id} => $_->{v};
} @$a};

use Data::Dumper;
warn Dumper $h;