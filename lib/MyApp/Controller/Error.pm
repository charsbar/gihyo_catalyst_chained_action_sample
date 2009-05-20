package MyApp::Controller::Error;

use Moose;
BEGIN { extends 'Catalyst::Controller'; }
use HTTP::Status;

sub not_found : Private {
    my ($self, $c) = @_;

    $c->res->body(HTTP::Status::status_message(RC_NOT_FOUND));
    $c->res->status(RC_NOT_FOUND);
    $c->detach;
}

__PACKAGE__->meta->make_immutable;

1;
