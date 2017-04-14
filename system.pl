use strict;
use warnings;
use utf8;


my $a = `git --vesion`;
print $?;
print $a;
