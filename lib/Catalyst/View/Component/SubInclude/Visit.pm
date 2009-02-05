package Catalyst::View::Component::SubInclude::Visit;
use warnings;
use strict;

use Carp qw/croak/;
use namespace::clean qw/croak/;

=head1 NAME

Catalyst::View::Component::SubInclude::Visit - visit() plugin for C::V::Component::SubInclude

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

In your view class:

  package MyApp::View::TT;
  use Moose;

  extends 'Catalyst::View::TT';
  with 'Catalyst::View::Component::SubInclude';

  __PACKAGE__->config( subinclude_plugin => 'Visit' );

Then, somewhere in your templates:

  [% subinclude('/my/widget') %]

=head1 DESCRIPTION

C<Catalyst::View::Component::SubInclude::Visit> uses C<< $c->visit() >> to 
render subinclude contents.

This method is only supported when using L<Catalyst> version 5.71000 or newer.

=head1 CLASS METHODS

=head2 C<generate_subinclude( $c, $path, @args )>

This will translate to the following call:

  $c->visit( $path, @args );

=cut

sub generate_subinclude {
    my ($class, $c, $path, @params) = @_;

    croak "subincludes through visit() require Catalyst version 5.71000 or newer"
        unless $c->can('visit');

    $c->visit( $path, @params );
    $c->res->{body};
}

=head1 SEE ALSO

L<Catalyst::View::Component::SubInclude|Catalyst::View::Component::SubInclude>, 
L<Catalyst|Catalyst>

=head1 AUTHOR

Nilson Santos Figueiredo Junior, C<< <nilsonsfj at cpan.org> >>

=head1 SPONSORSHIP

Development sponsored by Ionzero LLC L<http://www.ionzero.com/>.

=head1 COPYRIGHT & LICENSE

Copyright (C) 2009 Nilson Santos Figueiredo Junior.

Copyright (C) 2009 Ionzero LLC.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
