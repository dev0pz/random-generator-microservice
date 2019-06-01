#!/usr/bin/env perl

use Mojolicious::Lite;
use Crypt::OpenSSL::Random;
use Digest::SHA qw(sha512_hex);
use lib '/app';
use EncodePassword;


app->hook(after_dispatch => sub {
    my $tx = shift;
    $tx->res->headers->header("Server" => "PRNG v1");
    $tx->res->headers->header("Access-Control-Allow-Origin" => "*");
    $tx->res->headers->header("Cache-Control" => "max-age=1, no-cache, must-revalidate");
});



## new ext sum {}
## dsfkfwlefjwelkf::::9234
## exp(345)*in wr234


get '/' => sub {
    my $self = shift;
    $self->render_later;
    my ($rand, $pass, $rndn);
    my $entropy = `cat /proc/sys/kernel/random/entropy_avail`;
    chomp($entropy);
    $entropy = $entropy * 1;
    if ( Crypt::OpenSSL::Random::random_status() ) {
        my $rnd = Crypt::OpenSSL::Random::random_bytes(128);
        $rand = sha512_hex($rnd);
        $rndn = join("", unpack("L[16]",$rnd));
        $pass = Encode::PasswdChars::encode_passwd(join("", unpack("L[4]",$rnd)));
    }

    return $pass ? $self->render( text => $pass, format => 'txt') : $self->render( text => undef, format => 'txt' ) if $self->req->param('passwd');
    return $rand ? $self->render( json => {'rnd' => $rand, 'passwd' => $pass, 'rndnum' => $rndn, 'entropy' => $entropy , 'msg' => 'done' }  ) : $self->render( json => {'rnd' => undef, 'entropy' => $entropy , 'msg' => 'Unable to sufficiently seed the RNG, try later'} );
};

app->config(
    hypnotoad => {
        listen  => ['http://*:3000'],
        workers => 1,
        proxy   => 1,
    }
);

# change this
app->secrets(['AfJYTHDG$$jr9!r!XdYq;V9,ke,HMcTxxiTcSG2lk3j4234234nhfgiuast4398ur^$%$%#TuyTtY1#nm_fF7u']);
app->start;

__DATA__


@@ not_found.html.ep
<!DOCTYPE html>
<html>
Not Found
</html>

@@ not_found.development.html.ep
<!DOCTYPE html>
<html>
Not Found
</html>

@@ exception.html.ep
<!DOCTYPE html>
<html>
Fail
</html>

@@ exception.development.html.ep
<!DOCTYPE html>
<html>
Fail
</html>
