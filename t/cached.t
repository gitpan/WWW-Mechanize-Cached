use strict;
use warnings FATAL => 'all';
use Test::More tests => 3;
use constant URL => 'http://www.time.gov/timezone.cgi?Central/d/-6';

BEGIN {
    use_ok( 'WWW::Mechanize::Cached' );
}

my $mech = WWW::Mechanize::Cached->new( autocheck => 1 );
isa_ok( $mech, 'WWW::Mechanize::Cached' );

my $first  = $mech->get( URL )->content;
my $second = $mech->get( URL )->content;
sleep 3; # 3 due to Referer header
my $third  = $mech->get( URL )->content;

is( $second => $third, "Second and third match" );
