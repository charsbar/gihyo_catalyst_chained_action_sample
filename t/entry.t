use strict;
use warnings;
use Catalyst::Test 'MyApp';
use Test::More tests => 5;
use HTTP::Status;
use HTTP::Request;

my ($res, $c) = ctx_request('/entry/1');
ok $res->code == RC_OK;
ok $c->stash->{template} eq 'entry';

my $req = HTTP::Request->new(GET => '/entry/1/create');

($res, $c) = ctx_request($req);
ok $res->code == RC_UNAUTHORIZED;

$req->header('Cookie' => 'session=foo');

($res, $c) = ctx_request($req);
ok $res->code == RC_OK;
ok $c->stash->{template} eq 'create';
