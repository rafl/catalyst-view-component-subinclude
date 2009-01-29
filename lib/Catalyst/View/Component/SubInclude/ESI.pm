package Catalyst::View::Component::SubInclude::ESI;
use warnings;
use strict;

sub generate_subinclude {
    my $class = shift;
    my $c     = shift;
    my $url = $c->uri_for( @_ );
    return '<!--esi <esi:include src="' . $url->path . '" /> -->';
}

1;
