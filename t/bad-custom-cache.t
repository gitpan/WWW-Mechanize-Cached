use strict;
use warnings FATAL => 'all';
use lib 't';

use Test::More;
use WWW::Mechanize::Cached;
use Test::Warn;

eval "use Test::Warn";
plan skip_all => "Test::Warn required for testing invalid cache parms" if $@;
plan tests=>2;

my $mech;

warning_like {
    $mech = WWW::Mechanize::Cached->new( cache => { parm => 73 }, autocheck => 1 );
} qr/cache object/, "Threw the right warning";

isa_ok( $mech, "WWW::Mechanize::Cached", "Even with a bad cache, still return a valid object" );
