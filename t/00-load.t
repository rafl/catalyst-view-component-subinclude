#!perl -T

use Test::More tests => 3;

BEGIN {
	use_ok( 'Catalyst::View::Component::SubInclude' );
    use_ok( 'Catalyst::View::Component::SubInclude::SubRequest' );
    use_ok( 'Catalyst::View::Component::SubInclude::ESI' );
}

diag( "Testing Catalyst::View::Component::SubInclude $Catalyst::View::Component::SubInclude::VERSION, Perl $], $^X" );
