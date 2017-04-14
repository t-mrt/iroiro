use strict;
use warnings;
use utf8;
use feature qw(say);

use Devel::Peek;
use Encode qw(decode_utf8 encode_utf8 decode encode);
use DBI;
use JSON::XS;

sub p {
    my $s = shift @_;

    my $stderr;

    # Devel::Peek::Dump がエラー出力されてしまうので
    # 一時的にエラー出力先を切り替え開き直す
    # ちゃんと開き直してるので Wide character in print 警告はちゃんと出る
    {
        open my $temp, '>&', STDERR;
        close STDERR;
        open STDERR, '>', \$stderr;

        Devel::Peek::Dump($s);

        close STDERR;
        open STDERR, '>&', $temp;
        close $temp;
    }

    my $is_oct;
    # sub p はバイト列を返す
    # したがって $s が内部表現場合 encode_utf8 し、バイト列の場合 そのまま
    if ($stderr =~ m/UTF8/){
        $is_oct = 0;
    } else {
        $is_oct = 1;
    }
    return $is_oct;
}

my $dbh = DBI->connect("DBI:mysql:database=test;host=localhost","nobody", "nobody");

$dbh->{mysql_enable_utf8} = 1;

my $s1 = "道後"; # => 内部表現
my $s2 = encode_utf8 "道後"; # => バイト列

my $j = JSON::XS->new->utf8->encode(+JSON::XS->new->decode(JSON::XS->new->encode([hoge => 'あいうえお'])));

Devel::Peek::Dump(JSON::XS->new->utf8->encode([hoge => 'あいうえお']));


warn $j;

# $dbh->do(q[
#     INSERT `test_text_blob` (c_text, c_blob, c_char, c_bina) VALUES (?, ?, ?, ?)
# ], undef, $s1, $s1, $s1, $s1);
#
# mysql> select * from test_text_blob;
# +--------+--------+--------+--------+
# | c_text | c_blob | c_char | c_bina |
# +--------+--------+--------+--------+
# | 道後   | 道後   | 道後   | 道後   |
# +--------+--------+--------+--------+
# 1 row in set (0.00 sec)

# $dbh->do(q[
#     INSERT `test_text_blob` (c_text, c_blob, c_char, c_bina) VALUES (?, ?, ?, ?)
# ], undef, $s2, $s2, $s2, $s2);
#
# mysql> select * from test_text_blob;
# +--------------+--------------+--------------+--------------+
# | c_text       | c_blob       | c_char       | c_bina       |
# +--------------+--------------+--------------+--------------+
# | éå¾       | éå¾       | éå¾       | éå¾       |
# +--------------+--------------+--------------+--------------+
# 1 row in set (0.00 sec)

$dbh->do(q[
    INSERT `test_text_blob` (c_text, c_blob, c_char, c_bina) VALUES (?, ?, ?, ?)
], undef, $j, $j, $j, $j);

my $sth = $dbh->prepare(q[select * from test_text_blob]);
$sth->execute();
my $result;
while (my $ref = $sth->fetchrow_arrayref()) {
    my $c_text = $ref->[0];
    my $c_blob = $ref->[1];
    my $c_char = $ref->[2];
    my $c_bina = $ref->[3];


    say encode_utf8("c_text");
    say p($c_text) ? encode_utf8 "オクト列" : encode_utf8 "内部表現";
    say $s1 eq $c_text ? encode_utf8 "元の文字列と一致" : encode_utf8 "元の文字列と不一致";

    say encode_utf8("c_blob");
    say p($c_blob) ? encode_utf8 "オクト列" : encode_utf8 "内部表現";
    say $s2 eq $c_blob ? encode_utf8 "元の文字列と一致" : encode_utf8 "元の文字列と不一致";

}
$sth->finish();

$dbh->disconnect();

__END__

CREATE TABLE `test_text_blob` (
  `c_text` TEXT NOT NULL,
  `c_blob` BLOB NOT NULL,
  `c_char` VARCHAR(100) NOT NULL,
  `c_bina` VARBINARY(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
