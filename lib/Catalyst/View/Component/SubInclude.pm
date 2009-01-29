package Catalyst::View::Component::SubInclude;
use Moose::Role;

use Carp qw/croak/;
use namespace::clean qw/croak/;

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

1;
