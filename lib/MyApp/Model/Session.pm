package MyApp::Model::Session;

use Moose;
extends 'Catalyst::Model';
use MyApp::Item::Session;
use Path::Extended;
use Digest::MD5 'md5_hex';

has 'root' => (is => 'rw', isa => 'Str', default => 'session');

sub get {
    my ($self, $id) = @_;

    my $file = file($self->root, $id);
    my $session = MyApp::Item::Session->new(file => $file);

    return unless $session->exists;
    return $session;
}

sub set {
    my ($self, $params) = @_;

    my $id = $params->{id} || md5_hex(time.rand().$$);

    my $file = file($self->root, $id);
    my $session = MyApp::Item::Session->new(file => $file);
    $session->save($params);
    return $session->id;
}

sub remove {
    my ($self, $id) = @_;

    my $file = file($self->root, $id);
    my $session = MyApp::Item::Session->new(file => $file);
    $session->remove;
}

__PACKAGE__->meta->make_immutable;

1;
