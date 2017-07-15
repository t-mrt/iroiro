use strict;

use Regexp::List;
my $rl = Regexp::List->new();
my @list = ('ab+c','ab+-','a\w\d+', 'a\d+');

print "ok" if "a"  =~ $rl->list2re(@list);
