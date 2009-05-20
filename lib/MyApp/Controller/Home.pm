package MyApp::Controller::Home;

use Moose;
BEGIN { extends 'Catalyst::Controller'; }

sub latest_entries : Chained('/root') PathPart('') Args(0) {
    my ($self, $c) = @_;

    $c->stash->{entries}  = $c->model('DB')->latest_entries(5);
    $c->stash->{template} = 'home';
}

__PACKAGE__->meta->make_immutable;

1;
