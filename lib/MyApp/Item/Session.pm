package MyApp::Item::Session;

use Moose; with 'MyApp::Role::Item::YAML';
use Encode;

has 'data' => (
    is      => 'rw',
    isa     => 'HashRef',
    default => sub { +{} },
);

sub _set {
    my ($self, $params) = @_;

    $self->data($params->{data});
}

sub _encode_params {
    my $self = shift;

    return {
        data => $self->data,
    };
}

__PACKAGE__->meta->make_immutable;

1;
