use strict;
use warnings;
use utf8;



my %a = (
    a => "a",
    b => "b",
    c => "c",
);

%a = (
    %a,
    a => "aa",
    'o-o' => "a",
);

use Data::Dumper;
warn Dumper \%a;

