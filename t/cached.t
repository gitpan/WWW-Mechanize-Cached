#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Test::More tests => 3;
use vars qw( $class );

BEGIN {
    $class = 'WWW::Mechanize::Cached';
    use_ok $class;
}

# ------------------------------------------------------------------------

{
    my $c = $class->new;
    isa_ok( $c => $class );

    my $first  = $c->get( 'http://dellah.org/time.cgi' )->content;
    sleep 3;
    my $second = $c->get( 'http://dellah.org/time.cgi' )->content;
    sleep 3; # 3 due to Referer header
    my $third  = $c->get( 'http://dellah.org/time.cgi' )->content;

    is( $second => $third, "Got the same times" );

}
