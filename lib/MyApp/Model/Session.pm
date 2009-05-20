package MyApp::Model::Session;

use Moose;
extends 'Catalyst::Model';

sub get {
    my ($self, $id) = @_;

    return unless $id;

    my $session = {
        id   => $id,
        data => {
            user_id => 'admin',
        },
    };

    return $session;
}

sub remove {
    my ($self, $id) = @_;

}

__PACKAGE__->meta->make_immutable;

1;
