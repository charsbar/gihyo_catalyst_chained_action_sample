package MyApp::Controller::Root;

use Moose;
BEGIN { extends 'Catalyst::Controller'; }

__PACKAGE__->config->{namespace} = '';

sub root : Chained('/') PathPart('') CaptureArgs(0) {
    my ($self, $c) = @_;
}

sub default : Private {
    my ($self, $c) = @_;

    $c->forward('/error/not_found');
}

sub end : ActionClass('RenderView') {}

__PACKAGE__->meta->make_immutable;

1;
