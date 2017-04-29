use strict;
use warnings;

my $app = sub {
    my $env = shift;
    warn time;
    return [
        200,
        [
            'Content-Type' => 'text/plain',
            'Cache-Control' => 'max-age=3,stale-while-revalidate=5',
        ],
        [ time ],
    ];
};

return  $app;
