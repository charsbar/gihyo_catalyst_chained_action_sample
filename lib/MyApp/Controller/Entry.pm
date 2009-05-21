package MyApp::Controller::Entry;

use Moose;
BEGIN { extends 'Catalyst::Controller'; }

sub entry : Chained('/root') PathPart CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    $c->stash->{entry} = $c->model('DB')->entry($id);
}

sub default_read : Chained('entry') PathPart('') Args(0) {
    my ($self, $c) = @_;

    $c->forward('/entry/read');
}

sub read : Chained('entry') PathPart Args(0) {
    my ($self, $c) = @_;

    if (!$c->stash->{entry}->exists) {
        if ($c->stash->{user}) {
            $c->forward('create');
        }
        else {
            $c->forward('/error/not_found');
        }
        $c->detach;
    }

    $c->stash->{template} = 'entry';
}

sub create : Chained('entry') PathPart Args(0) {
    my ($self, $c) = @_;

    $c->forward('/error/unauthorized') unless $c->stash->{user};

    if (uc $c->req->method eq 'POST') {
        $c->stash->{entry}->create($c->req->params);
        $c->res->redirect($c->uri_for('/'));
        $c->detach;
    }

    $c->stash->{template} = 'create';
}

__PACKAGE__->meta->make_immutable;

1;
