package MyApp::Role::Item::YAML;

use Moose::Role;
use YAML;

requires qw( _set _encode_params );

has 'file' => (
    is      => 'rw',
    isa     => 'Path::Extended::File',
    trigger => sub {
        my ($self, $file) = @_;
        $file->exists ? $self->read : $self->clear;
    },
    handles => [qw( remove )],
);

sub clear {
    my $self = shift;

    foreach my $attribute ($self->meta->get_all_attributes) {
        next unless $attribute->has_default;
        $attribute->set_value($self, $attribute->default($self));
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

sub save {
    my $self = shift;

    $self->file->save(YAML::Dump($self->_encode_params), { mkdir => 1 });
}

1;
