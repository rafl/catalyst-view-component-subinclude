package Catalyst::View::Component::SubInclude::Visit;
use warnings;
use strict;

use Carp qw/croak/;
use namespace::clean qw/croak/;

=head1 NAME

Catalyst::View::Component::SubInclude::Visit - visit() plugin for C::V::Component::SubInclude

=head1 VERSION

Version 0.03

=cut

our $VERSION = '0.03';

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

B<WARNING: As of Catalyst version 5.71000, this plugin doesn't work for chained 
actions with captured arguments>. Apparently, C<visit> doesn't handle this type 
of actions yet.

=head1 CLASS METHODS

=head2 C<generate_subinclude( $c, $path, @args )>

This is (roughly) equivalent to the following call:

  $c->visit( $path, @args );

But it will handle all the nasty details such as localizing the stash, 
parameters and response body. This is necessary to keep behavior consistent 
with the other plugins.

=cut

sub generate_subinclude {
    my ($class, $c, $path, @params) = @_;

    croak "subincludes through visit() require Catalyst version 5.71000 or newer"
        unless $c->can('visit');
    
    $c->log->debug("generate subinclude: $path @params");

    {
        local $c->{stash} = {};
        
        local $c->request->{parameters} = 
            ref $params[-1] eq 'HASH' ? pop @params : {};

        local $c->response->{body};

        $c->visit( $path, ( ref $params[0] eq 'ARRAY' ? shift @params : () ) );

        return $c->response->{body};
    }

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
