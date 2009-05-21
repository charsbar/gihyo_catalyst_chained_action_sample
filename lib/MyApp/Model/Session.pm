package MyApp::Model::Session;

use Moose;
extends 'Catalyst::Model';
use MyApp::Item::Session;
use Path::Extended;
use Digest::MD5 'md5_hex';

has 'root' => (
    is      => 'rw',
    isa     => 'Str',
    default => $ENV{MYAPP_TEST} ? 't/session' : 'session',
);

sub _item {
    my ($self, $id) = @_;

    my $file = file($self->root, $id);
    return MyApp::Item::Session->new(file => $file);
}

sub get {
    my ($self, $id) = @_;

    my $session = $self->_item($id);

    return unless $session->exists;
    return $session;
}

sub set {
    my ($self, $params) = @_;

    my $id = $params->{id} || md5_hex(time.rand().$$);

    my $session = $self->_item($id);
    $session->create($params);
    return $session->id;
}

sub remove {
    my ($self, $id) = @_;

    my $session = $self->_item($id);
    $session->remove;
}

__PACKAGE__->meta->make_immutable;

1;
