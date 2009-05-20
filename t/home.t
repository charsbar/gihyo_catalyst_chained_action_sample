use strict;
use warnings;
use Catalyst::Test 'MyApp';
use Test::More tests => 2;
use HTTP::Status;

my ($res, $c) = ctx_request('/');
ok $res->code == RC_OK;
ok $c->stash->{template} eq 'home';
