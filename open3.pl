use strict;
use warnings;

use feature qw(say);

use IPC::Open3;
use IO::Select;
use Symbol;

my $cmd = "carton exec -- perl str_flow.pl";

my ($out_fh,  $err_fh) = (gensym(), gensym());
open3(undef, $out_fh,  $err_fh, $cmd);


() = <$out_fh>;
() = <$err_fh>;


=END=
my $sel = new IO::Select;
$sel->add($out_fh,$err_fh);

my $out_message = '';
my $err_message = '';

while(my @readable_fh = $sel->can_read) {

    foreach my $fh (@readable_fh) {
        my $line;
        my $len = sysread $fh, $line, 2000;

        if(!defined $len){
            die;
        } elsif ($len == 0){
            $sel->remove($fh);
        } else {
            if($fh == $out_fh) {
                $out_message .= $line;
            } elsif($fh == $err_fh) {
                $err_message .= $line;
            } else {
                die "";
            }
        }
    }
}
