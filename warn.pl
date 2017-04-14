use strict;
use warnings;
use utf8;

my $stderr;

open my $temp, '>&', STDERR;
close STDERR;
open STDERR, '>', \$stderr;

warn "hoge";

close STDERR;
open STDERR, '>&', $temp;
close $temp;
