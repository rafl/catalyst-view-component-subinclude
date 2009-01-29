# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'Catalyst-Plugin-SubInclude';
all_from 'lib/Catalyst/Plugin/SubInclude.pm';

requires 'Catalyst::Runtime' => '5.7014';
requires 'Catalyst::Plugin::SubRequest';
requires 'Moose';
requires 'Moose::Role';

catalyst;

auto_install;
WriteAll;
