use strict;
use warnings;

use feature qw(say);
use IO::File;

for (1..5) {
    my $io = IO::File->new("a.text", "r");
    my $l = $io->getline or die "pp";
    $io->close;
    say $l;
}