package MyApp::Item::User;

use Moose; with 'MyApp::Role::Item::YAML';
use Encode;
use Digest::MD5 'md5_hex';

has 'name'     => (is => 'rw', isa => 'Str', default => '');
has 'password' => (is => 'rw', isa => 'Str', default => '');

around 'create' => sub {
    my ($self, $params) = @_;

    $params->{password} = md5_hex($params->{password});
    inner();
};

sub _set {
    my ($self, $params) = @_;

    $self->name(decode_utf8($params->{name}));
    $self->password($params->{password});
}

sub _encode_params {
    my $self = shift;

    return {
        name     => encode_utf8($self->name),
        password => $self->password,
    };
}

sub challenge_password {
    my ($self, $password) = @_;

    return ( $self->password eq md5_hex($password) ) ? 1 : 0;
}

__PACKAGE__->meta->make_immutable;

1;
