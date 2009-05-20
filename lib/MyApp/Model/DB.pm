package MyApp::Model::DB;

use Moose;
extends 'Catalyst::Model';

sub latest_entries {
    my ($self, $num) = @_;

    my @entries;

    return \@entries;
}

sub entry {
    my ($self, $id) = @_;

    my $entry;

    return $entry;
}

__PACKAGE__->meta->make_immutable;

1;
