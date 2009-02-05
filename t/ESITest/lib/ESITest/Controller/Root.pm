package ESITest::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

__PACKAGE__->config->{namespace} = '';

sub index :Path Args(0) {
    my ( $self, $c ) = @_;
}

sub base : Chained('/') PathPart('') CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub time_include : Chained('base') PathPart('time') Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{current_time} = localtime();
}

sub end : ActionClass('RenderView') {}

1;
