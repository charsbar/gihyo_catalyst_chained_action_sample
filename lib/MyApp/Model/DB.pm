package MyApp::Model::DB;

use Moose;
extends 'Catalyst::Model';
use MyApp::Item::Entry;
use Path::Extended;

sub latest_entries {
    my ($self, $num) = @_;

    my @entries;

    return \@entries;
}

sub entry {
    my ($self, $id) = @_;

    my $file = file('data', $id);
    my $entry = MyApp::Item::Entry->new(file => $file);

    return $entry;
}

__PACKAGE__->meta->make_immutable;

1;
