use strict;
use warnings;

use IPC::Open3 qw(open3);

use feature qw(say);



my $file = './kisotisiki.jpg';
my @upload_cmd =  ("aws", "s3", "cp", $file, "s3://img.yux3.net/kisotisiki_4.jpg");

my $pid = open3(undef, my $out, 0, @upload_cmd);
waitpid($pid, 0);

my $child_exit_status = $? >> 8;
my $message = <$out>;
close $out;

if (!$child_exit_status) {
    say "SUCCESS:", $message;
} else {
    say "FAIL", $message;
}
