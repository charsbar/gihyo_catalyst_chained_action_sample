use strict;
use warnings;
use inc::Module::Install;

name 'MyApp';
all_from 'lib\MyApp.pm';

requires 'Catalyst::Runtime' => '5.80004';
requires 'Catalyst::Action::RenderView';

test_requires 'Test::More' => '0.47';
test_requires 'Test::UseAllModules' => '0.11';

auto_install;
WriteAll;