use strict;
use warnings;

use feature qw(say);

use Encode qw(decode_utf8 encode_utf8);

# {
#     use utf8;
#     if('友' =~ m/\A.\z/ ){
#         say 'a';
#     }
# }
#
# {
#     use utf8;
#     if('友' =~ m/\A...\z/ ){
#         say 'b';
#     }
# }
#
# {
#     no utf8;
#     if('友' =~ m/\A.\z/ ){
#         say 'c';
#     }
# }
#
# {
#     no utf8;
#     if('友' =~ m/\A...\z/ ){
#         say 'd';
#     }
# }
#
# {
#     use utf8;
#     if(encode_utf8 '友' =~ m/\A.\z/ ){
#         say 'e';
#     }
# }
#
# {
#     use utf8;
#     if(encode_utf8 '友' =~ m/\A...\z/ ){
#         say 'f';
#     }
# }
#
# {
#     use utf8;
#     if(encode_utf8 '友' =~ m/\A.\z/ ){
#         say 'g';
#     }
# }

{
    my $str;
    my $regexp;

    {
        no utf8;
        $str = '感';
    }

    {
        no utf8;
        $regexp = '(\A.\z)';
    }

    use utf8;
    if($str =~ $regexp ){
        say 'h';
    }
}
