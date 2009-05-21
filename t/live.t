use strict;
use warnings;
use Test::Classy;
use lib 't/lib';

local $ENV{MYAPP_TEST} = 1;

load_tests_from 'MyApp::Test::Live';
run_tests;
