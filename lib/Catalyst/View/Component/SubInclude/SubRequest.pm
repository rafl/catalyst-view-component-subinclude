package Catalyst::View::Component::SubInclude::SubRequest;
use warnings;
use strict;

sub generate_subinclude {
    my ($class, $c, $path, $params) = @_;
    my $stash = {};

    croak "subincludes through subrequests require Catalyst::Plugin::SubRequest"
        unless $c->can('sub_request');

    $c->sub_request( $path, $stash, $params );
}

1;
