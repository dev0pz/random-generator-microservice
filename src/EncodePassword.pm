package Encode::PasswdChars;

use strict;
use base qw(Exporter);
our @EXPORT = qw( encode_passwd decode_passwd );

my @alpha = qw(
    1 2 3 4 5 6 7 8 9
    a b c d e f g h i
    j k m n o p q r s
    t u v w x y z A B
    C D E F G H J K L
    M N P Q R S T U V
    W X Y Z # @ _ + =
    $ % & - ! ? ~
);

my $i = 0;
my %alpha = map { $_ => $i++ } @alpha;

sub encode_passwd {
    my $num = shift;
    return $alpha[0] if $num == 0;

    my $res = '';
    my $base = @alpha;
    while ($num > 0) {
        my $remain = $num % $base;
        $num = int($num / $base);
        $res = $alpha[$remain] . $res;
    }
    return $res;
}

sub decode_passwd {
    my $str = shift;
    my $decoded = 0;
    my $multi   = 1;
    my $base    = @alpha;
    while (length $str > 0) {
        my $digit = chop $str;
        $decoded += $multi * $alpha{$digit};
        $multi   *= $base;
    }
    return $decoded;
}

1;

