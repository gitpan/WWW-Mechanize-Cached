package WWW::Mechanize::Cached;
use strict;
use warnings FATAL => 'all';
use vars qw( $VERSION );
$VERSION = '1.23';

use base qw( WWW::Mechanize );
use Carp qw( carp croak );
use Storable qw( freeze thaw );
use Cache::Cache;

my %default = (
    class => 'Cache::FileCache',
    args => {
        namespace => __PACKAGE__,
        default_expires_in => "1d",
    }
);
my $key = __PACKAGE__;

sub new
{
    my $class = shift;
    my %args = @_;
    my %opts = %default;
    if (exists $args{cache})
    {
        my %new = %{ delete $args{cache} };
        $opts{class} = delete $new{class} if exists $new{class};
        %{$opts{args}} = ( %{ $opts{args} }, %new );
        croak "Bad class name" unless $opts{class} =~ /^[\w:]+$/;
    }
    my $self = $class->SUPER::new( %args );
    eval "use $opts{class}";
    my $c = $opts{class}->new( $opts{args} );
    $self->{$key} = $c;
    return $self;
}

sub _make_request
{
    my $self = shift;
    my $c = $self->{$key};
    my $request = shift;
    my $key = $request->as_string;
    my $v = $c->get( $key );
    if ($v) {
        $v = thaw $v;
    } else {
        $v = $self->SUPER::_make_request( $request, @_ );
        $c->set( $key, freeze($v) );
    };

    # An odd line to need.
    $self->{proxy} = {} unless defined $self->{proxy};

    return $v;
}

1;

__END__

=head1 NAME

WWW::Mechanize::Cached - Cache resposne to be polite

=head1 SYNOPSIS

    use WWW::Mechanize::Cached;

    my $cacher = WWW::Mechanize::Cached->new(
        cache => {
            class => "Cache::FileCache",
            args => {
               ...
            },
        },
    );

    $cacher->get( $url );

=head1 DESCRIPTION

Uses the L<Cache::Cache> hierarchy to implement a caching
Mech. This lets one perform repeated requests without
hammering a server impolitely.

=head1 CONSTRUCTOR

=head2 new

Behaves like, and calls, L<WWW::Mechanize>'s C<new> method.

Supports the additional key C<cache> which should be a hashref
containing any of two optional keys.

=over 4

=item class

Should be the L<Cache::Cache> based module to use. The default is
L<Cache::FileCache>.

=item args

Should be the arguments to pass to that module's own C<new> constructor.
Default contents are C<namespace> (set to C<WWW::Mechanize::Cached>) and
C<default_expires_in> (set to C<1d>).

=back

=head1 METHODS

All methods are provided by L<WWW::Mechanize>. See taht module's
documentation for details.

=head1 THANKS

Andy Lester (PETDANCE) for L<WWW::Mechanize>.

=head1 ODDITIES

It may sometimes seem as if it's not caching something. And this
may well be true. It uses the HTTP request, in string form, as the key
to the cache entries, so any minor changes will result in a different
key. This is most noticable when following links as L<WWW::Mechanize>
adds a C<Referer> header.

=head1 BUGS, REQUESTS, COMMENTS

Support for this module is provided via the CPAN RT system:

    http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Mechanize-Cached
    ( shorter URL: http://xrl.us/63i )

    bug-www-mechanize-cached@rt.cpan.org

This makes it much easier for me to track things and thus means
your problem is less likely to be neglected.

=head1 LICENCE AND COPYRIGHT

This module is copyright E<copy> Iain Truskett, 2003. All rights
reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.000 or,
at your option, any later version of Perl 5 you may have available.

The full text of the licences can be found in the F<Artistic> and
F<COPYING> files included with this module, or in L<perlartistic> and
L<perlgpl> as supplied with Perl 5.8.1 and later.

=head1 AUTHOR

Iain Truskett <spoon@cpan.org>

=head1 SEE ALSO

L<perl>, L<WWW::Mechanize>.

=cut
