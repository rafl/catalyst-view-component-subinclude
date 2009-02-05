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
    my $params = $c->req->params;

    $c->stash->{current_time} = localtime();
    
    my $additional = '';
    for my $key (keys %$params) {
        $additional .= "| $key = $params->{$key} | "
    }

    $c->stash->{additional} = $additional;
    
}

sub capture : Chained('base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $arg ) = @_;
    $c->log->debug("Capture: $arg");
    $c->stash->{additional} = "Arg: $arg";
}

sub time_args : Chained('capture') PathPart('time') Args(0) {
    my ( $self, $c ) = @_;
    my $params = $c->req->params;

    $c->stash->{current_time} = localtime();

    my $additional = $c->stash->{additional};
    for my $key (keys %$params) {
        $additional .= "| $key = $params->{$key} | "
    }

    $c->stash->{additional} = $additional;

    $c->stash->{template} = 'time_include.tt';
}

sub end : ActionClass('RenderView') {}

1;
