package Catalyst::View::Component::SubInclude::SubRequest;
use warnings;
use strict;

use Carp qw/croak/;
use namespace::clean qw/croak/;

=head1 NAME

Catalyst::View::Component::SubInclude::SubRequest - Sub-requests plugin for C::V::Component::SubInclude

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

In your application class:

  package MyApp;

  use Catalyst qw/
    ConfigLoader
    Static::Simple
    ...
    SubRequest
  /;

In your view class:

  package MyApp::View::TT;
  use Moose;

  extends 'Catalyst::View::TT';
  with 'Catalyst::View::Component::SubInclude';

  __PACKAGE__->config( subinclude_plugin => 'SubRequest' );

Then, somewhere in your templates:

  [% subinclude('/my/widget') %]

=head1 DESCRIPTION

C<Catalyst::View::Component::SubInclude::SubRequest> uses Catalyst sub-requests
to render the subinclude contents. 

It requires L<Catalyst::Plugin::SubRequest>.

=head1 CLASS METHODS

=head2 C<generate_subinclude( $c, $path, @args )>

This will translate to the following sub-request call:

  $c->sub_request( $path, {}, @args );

Notice that the stash will always be empty. This behavior could be configurable
in the future through an additional switch - for now, this behavior guarantees a
common interface for plugins.

=cut

sub generate_subinclude {
    my ($class, $c, $path, @params) = @_;
    my $stash = {};

    croak "subincludes through subrequests require Catalyst::Plugin::SubRequest"
        unless $c->can('sub_request');

    $c->sub_request( $path, $stash, @params );
}

=head1 SEE ALSO

L<Catalyst::View::Component::SubInclude|Catalyst::View::Component::SubInclude>, 
L<Catalyst::Plugin::SubRequest|Catalyst::Plugin::SubRequest>

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
