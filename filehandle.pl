use strict;
use warnings;

use feature qw(say);

our $a = "文字";

use Data::Dumper;
warn Dumper *a{SCALAR};

open (my $fh, '<', 'sample.txt');

my $content = do {
    local $/;
    <$fh>;
};

say $content;
close $fh;


open (FH, '<', 'sample.txt');

warn Dumper *FH{IO}; # => $VAR1 = bless( , 'IO::File' );
say fileno FH; # => 3

my $content = do {
    local $/;
    <FH>;
};

say $content;
close FH;

warn Dumper *FH{IO}; # => $VAR1 = bless( , 'IO::File' );
say fileno FH; # => undef
