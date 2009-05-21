package MyApp::Item::Entry;

use Moose; with 'MyApp::Role::Item::YAML';
use Encode;

has 'body'   => (is => 'rw', isa => 'Str', default => '');
has 'author' => (is => 'rw', isa => 'Str', default => '');

sub _set {
    my ($self, $params) = @_;

    $self->body  (decode_utf8($params->{body}));
    $self->author(decode_utf8($params->{author}));
}

sub _encode_params {
    my $self = shift;

    return {
        body   => encode_utf8($self->body),
        author => encode_utf8($self->author),
    };
}

__PACKAGE__->meta->make_immutable;

1;
