package Catalyst::View::Component::SubInclude::ESI;
use warnings;
use strict;

=head1 NAME

Catalyst::View::Component::SubInclude::ESI - Edge Side Includes (ESI) plugin for C::V::Component::SubInclude

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

  __PACKAGE__->config( subinclude_plugin => 'ESI' );

Then, somewhere in your templates:

  [% subinclude('/my/widget') %]

=head1 DESCRIPTION

C<Catalyst::View::Component::SubInclude::ESI> renders C<subinclude> calls as 
Edge Side Includes (ESI) include directives. This is a feature implemented by 
Varnish (L<http://varnish.projects.linpro.no/>) which allows cache-efficient 
uses of includes.

=head1 CLASS METHODS

=head2 C<generate_subinclude( $c, @args )>

This will roughly translate to the following code:

  my $url = $c->uri_for( @args );
  return '<!--esi <esi:include src="$url" /> -->';

Notice that the stash will always be empty. This behavior could be configurable
in the future through an additional switch - for now, this behavior guarantees a
common interface for plugins.

=cut

sub generate_subinclude {
    my ($class, $c, $path, @params) = @_;

    my $dispatcher = $c->dispatcher;
    my ($action, $args) = $dispatcher->_invoke_as_path( $c, $path, @params );

    my $uri = $c->uri_for( $action, $args );

    return '<!--esi <esi:include src="' . $uri->path . '" /> -->';
}

=head1 SEE ALSO

L<Catalyst::View::Component::SubInclude|Catalyst::View::Component::SubInclude>, 
L<http://www.catalystframework.org/calendar/2008/17>,
L<http://varnish.projects.linpro.no/>

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
