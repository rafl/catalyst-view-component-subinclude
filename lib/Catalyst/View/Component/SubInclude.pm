package Catalyst::View::Component::SubInclude;
use Moose::Role;

use Carp qw/croak/;
use namespace::clean qw/croak/;

=head1 NAME

Catalyst::View::Component::SubInclude - Use subincludes in your Catalyst views

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

  package MyApp::View::TT;
  use Moose;

  extends 'Catalyst::View::TT';
  with 'Catalyst::View::Component::SubInclude';

  __PACKAGE__->config( subinclude_plugin => 'SubRequest' );

Then, somewhere in your templates:

  [% subinclude('/my/widget') %]

=head1 DESCRIPTION

C<Catalyst::View::Component::SubInclude> allows you to include content in your
templates (or, more generally, somewhere in your view's C<render> processing)
which comes from another action in your application. It's implemented as a 
L<Moose::Role|Moose::Role>, so using L<Moose|Moose> in your view is required.

Simply put, it's a way to include the output of a Catalyst sub-request somewhere
in your page. 

It's built in an extensible way so that you're free to use sub-requests, Varnish 
ESI (L<http://www.catalystframework.org/calendar/2008/17>) or any other 
sub-include plugin you might want to implement. An LWP plugin seems useful and
might be developed in the future.

=head1 STASH FUNCTION

This component does its magic by exporting a C<subinclude> coderef entry to the
stash. This way, it's easily accessible by the templates (which is the most 
common use-case).

=head2 C<subinclude( $path, @args )>

This will render and return the body of the included resource (as specified by 
C<$path>).

=head1 SUBINCLUDE PLUGINS

The module comes with two subinclude plugins: 
L<SubRequest|Catalyst::Plugin::View::Component::SubRequest> and 
L<ESI|Catalyst::Plugin::View::Component::ESI>.

By default, the SubRequest plugin will be used. This can be changed in the 
view's configuration options (either in the config file or in the view module
itself). 

Configuration file example:

  <View::TT>
      subinclude_plugin   ESI
  </View::TT>

=cut

has 'subinclude_plugin' => (
    is => 'rw',
    isa => 'ClassName'
); 

around 'new' => sub {
    my $next = shift;
    my $class = shift;
    
    my $self = $class->$next( @_ );
    
    my $subinclude_plugin = $self->config->{subinclude_plugin} || 'SubRequest';
    my $subinclude_class  = __PACKAGE__ . '::' . $subinclude_plugin;
    
    eval "require $subinclude_class";
    croak "Error requiring $subinclude_class: $@" if $@;

    $self->subinclude_plugin( $subinclude_class );
    
    $self;
};

around 'render' => sub {
    my $next = shift;
    my ($self, $c, @args) = @_;
    
    $c->stash->{subinclude} = sub {
        $self->subinclude_plugin->generate_subinclude( $c, @_ );
    };

    $self->$next( $c, @args );
};

=head1 SEE ALSO

L<Catalyst::Plugin::SubRequest|Catalyst::Plugin::SubRequest>, 
L<Moose::Role|Moose::Role>, L<Moose|Moose>,
L<http://www.catalystframework.org/calendar/2008/17>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-catalyst-view-component-subinclude at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-View-Component-SubInclude>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

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
