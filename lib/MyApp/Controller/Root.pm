package MyApp::Controller::Root;

use Moose;
BEGIN { extends 'Catalyst::Controller'; }

__PACKAGE__->config->{namespace} = '';

sub end : ActionClass('RenderView') {}

__PACKAGE__->meta->make_immutable;

1;
