package ESITest::View::TT;
use Moose;

extends 'Catalyst::View::TT';
with 'Catalyst::View::Component::SubInclude';

__PACKAGE__->config( TEMPLATE_EXTENSION => '.tt' );

1;
