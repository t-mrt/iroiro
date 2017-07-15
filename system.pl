use strict;
use warnings;
use utf8;

use constant o => ('--cache-control', 'public, max-age=0, s-maxage=86400');

sub shellquote {
    my @in = @_;
    return '' unless @in;
    my $ret = '';
    foreach (@in) {
        if (!defined $_ or $_ eq '') {
            $_ = "''";
        } elsif (/[^\w\d.\-\/]/) {
            s/\'/\'\\\'\'/g;
            $_ = "'$_'";
            s/^''//;
            s/''$//;
        }
        $ret .= "$_ ";
    }
    chop $ret;
    return $ret;
}

my @cmd = (
     'git',
     'diff',
     o,
     '.'
);
warn @cmd;
warn shellquote @cmd;


