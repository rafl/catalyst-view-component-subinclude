package Catalyst::View::Component::SubInclude::SubRequest;
use warnings;
use strict;

sub generate_subinclude {
    my ($class, $c, $path, $params) = @_;
    my $stash = {};
    $c->sub_request( $path, $stash, $params );
}

1;
