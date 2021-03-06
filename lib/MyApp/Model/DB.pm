package MyApp::Model::DB;

use Moose;
extends 'Catalyst::Model';
use MyApp::Item::Entry;
use Path::Extended;

has 'root' => (
    is      => 'rw',
    isa     => 'Str',
    default => $ENV{MYAPP_TEST} ? 't/data' : 'data',
);

sub latest_entries {
    my ($self, $num) = @_;

    $num ||= 5;

    my @entries;
    my $rootdir = dir($self->root);
    while( my $file = $rootdir->next ) {
        next if $file->is_dir;
        my $entry = [ $file, $file->mtime ];
        push @entries, $entry;
        my $max = @entries < $num ? @entries : $num;
        if ( @entries > 1 ) {
            @entries = (sort { $b->[1] <=> $a->[1] } @entries)[0 .. $max - 1];
        }
    }
    return [
        map { MyApp::Item::Entry->new(file => $_->[0]) } @entries
    ];
}

sub entry {
    my ($self, $id) = @_;

    my $file = file($self->root, $id);
    my $entry = MyApp::Item::Entry->new(file => $file);

    return $entry;
}

__PACKAGE__->meta->make_immutable;

1;
