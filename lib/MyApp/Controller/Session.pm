package MyApp::Controller::Session;

use Moose;
BEGIN { extends 'Catalyst::Controller'; }

sub check : Private {
    my ($self, $c) = @_;

    if ( my $cookie = $c->req->cookie('session') ) {
        my $session = $c->model('Session')->get($cookie->value);
        return unless $session;
        $c->stash->{session} = $session;
        $c->forward('/session/get_user');
    }
}

sub get_user : Private {
    my ($self, $c) = @_;

    my $session = $c->stash->{session};

    my $user_id = $session->{data}->{user_id};
    my $user = $c->model('User')->get($user_id);
    unless ($user) {
        $c->model('Session')->remove($session->{id});
        delete $c->stash->{session};
        return;
    }
    $c->stash->{user} = $user;
}

__PACKAGE__->meta->make_immutable;

1;
