package MyApp::Item::Entry;

use Moose;
use Encode;
use YAML;

has 'body'   => (is => 'rw', isa => 'Str', default => '');
has 'author' => (is => 'rw', isa => 'Str', default => '');

has 'file' => (
    is      => 'rw',
    isa     => 'Path::Extended::File',
    trigger => sub {
        my ($self, $file) = @_;
        $file->exists ? $self->read : $self->clear;
    }
);

sub clear {
    my $self = shift;

    foreach my $attribute (qw( body author )) {
        $self->$attribute('');
    }
}

sub exists {
    my $self = shift;

    return unless $self->file;
    return $self->file->exists;
}

sub id {
    my $self = shift;

    return '' unless $self->file;
    return $self->file->basename;
}

sub read {
    my $self = shift;

    return $self->clear unless $self->exists;

    my $params = YAML::LoadFile( $self->file ) || {};

    $self->_set($params);
}

sub create {
    my ($self, $params) = @_;

    $self->_set($params);
    $self->save;
}

sub _set {
    my ($self, $params) = @_;

    $self->body  (decode_utf8($params->{body}));
    $self->author(decode_utf8($params->{author}));
}

sub save {
    my $self = shift;

    my $params = {
        body   => encode_utf8($self->body),
        author => encode_utf8($self->author),
    };

    $self->file->save(YAML::Dump($params), { mkdir => 1 });
}

__PACKAGE__->meta->make_immutable;

1;
