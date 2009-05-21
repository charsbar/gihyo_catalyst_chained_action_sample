package MyApp::Model::User;

use Moose;
extends 'Catalyst::Model';
use MyApp::Item::User;
use Path::Extended;

has 'root' => (
    is      => 'rw',
    isa     => 'Str',
    default => $ENV{MYAPP_TEST} ? 't/user' : 'user',
);

sub _item {
    my ($self, $id) = @_;

    my $file = file($self->root, $id);
    return MyApp::Item::User->new(file => $file);
}

sub get {
    my ($self, $id) = @_;

    my $user = $self->_item($id);

    return unless $user->exists;
    return $user;
}

sub authenticate {
    my ($self, $params) = @_;

    my $id = $params->{id} or return;

    my $user = $self->_item($id);

    return unless $user->exists;
    return unless $user->challenge_password($params->{password});

    return $user;
}

__PACKAGE__->meta->make_immutable;

1;
