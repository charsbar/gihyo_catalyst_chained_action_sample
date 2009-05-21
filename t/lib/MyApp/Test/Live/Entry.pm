package MyApp::Test::Live::Entry;

use strict;
use warnings;
use Test::Classy::Base;
use Catalyst::Test 'MyApp';
use HTTP::Status;
use HTTP::Request;
use MyApp::Model::DB;
use MyApp::Model::User;
use MyApp::Model::Session;

sub entry_read : Tests(2) {
    my $class = shift;

    my $model = MyApp::Model::DB->new;
    my $entry = $model->entry('1');
    $entry->create({ body => 'foo', author => 'admin' });

    my ($res, $c) = ctx_request('/entry/1');
    ok $res->code == RC_OK, $class->message('status code is correct');
    ok $c->stash->{template} eq 'entry', $class->message('template is correct');

    $entry->remove;
}

sub entry_create_unauthorized : Test {
    my $class = shift;

    my $req = HTTP::Request->new(GET => '/entry/1/create');

    my ($res, $c) = ctx_request($req);
    ok $res->code == RC_UNAUTHORIZED, $class->message('status code is correct');
}

sub entry_create_authorized : Tests(2) {
    my $class = shift;

    my $user_model = MyApp::Model::User->new;
    my $user = $user_model->_item('admin');
    $user->create({ name => 'admin', password => 'foo' });

    my $session_model = MyApp::Model::Session->new;
    my $session = $session_model->_item('foo');
    $session->create({ data => { user_id => 'admin' }});

    my $req = HTTP::Request->new(GET => '/entry/1/create');

    $req->header('Cookie' => 'session=foo');

    my ($res, $c) = ctx_request($req);
    ok $res->code == RC_OK, $class->message('status code is correct');
    ok $c->stash->{template} eq 'create', $class->message('template is correct');

    $user->remove;
    $session->remove;
}

1;
