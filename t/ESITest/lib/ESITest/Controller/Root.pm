package ESITest::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

__PACKAGE__->config->{namespace} = '';

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
}

sub time_include : Local Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{current_time} = localtime();
}

sub end : ActionClass('RenderView') {
    my ( $self, $c ) = @_;
    $c->setup_esi;
}

1;
