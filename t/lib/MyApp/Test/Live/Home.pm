package MyApp::Test::Live::Home;

use strict;
use warnings;
use Test::Classy::Base;
use Catalyst::Test 'MyApp';
use HTTP::Status;

sub home : Tests(2) {
    my $class = shift;

    my ($res, $c) = ctx_request('/');
    ok $res->code == RC_OK, $class->message('status code is correct');
    ok $c->stash->{template} eq 'home', $class->message('template is correct');
}

1;
