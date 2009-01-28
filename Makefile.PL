# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'Catalyst-Plugin-ESI';
all_from 'lib/Catalyst/Plugin/ESI.pm';

requires 'Catalyst::Runtime' => '5.7014';
requires 'Catalyst::Plugin::SubRequest';

catalyst;

auto_install;
WriteAll;
