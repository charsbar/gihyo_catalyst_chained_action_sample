package MyApp::Model::User;

use Moose;
extends 'Catalyst::Model';

sub get {
    my ($self, $id) = @_;

    return unless $id eq 'admin';

    my $user = {
        id => $id,
    };

    return $user;
}

__PACKAGE__->meta->make_immutable;

1;
