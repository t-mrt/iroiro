use warnings;
use strict;
use IO::Handle;

for (1..10000){
    if(int rand 2){
        print STDOUT "@{[ '姉' x 100 ]}";
    } else {
        print STDERR "@{[ '姉' x 100 ]}";
    }
}
