package MyApp::Controller::Auth;

use Moose;
BEGIN { extends 'Catalyst::Controller'; }

sub login : Chained('/root') PathPart Args(0) {
    my ($self, $c) = @_;

    if (uc $c->req->method eq 'POST') {
        my $user = $c->model('User')->authenticate($c->req->params);
        if ( $user ) {
            $c->stash->{user} = $user;
            $c->forward('/auth/login_succeeded');
        }
    }
    $c->stash->{template} = 'login';
    $c->stash->{return_path} = $c->req->uri->path;
}

sub login_succeeded : Private {
    my ($self, $c) = @_;

    my $user = $c->stash->{user};

    my $session = { data => { user_id => $user->id } };
    my $session_id = $c->model('Session')->set( $session );
    $c->res->cookies->{session} = { value => $session_id };

    my $return_path = $c->req->param('return_path')
                   || $c->uri_for('/');

    $c->res->redirect($return_path);
    $c->detach;
}

sub logout : Chained('/root') PathPart Args(0) {
    my ($self, $c) = @_;

    $c->res->cookies->{session} = { expires => -1, value => '' };
    $c->res->redirect($c->uri_for('/'));
    $c->detach;
}

__PACKAGE__->meta->make_immutable;

1;
