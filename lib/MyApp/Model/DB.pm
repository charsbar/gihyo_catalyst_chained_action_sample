package MyApp::Model::DB;

use Moose;
extends 'Catalyst::Model';

sub latest_entries {
  my ($self, $num) = @_;

  my @entries;

  return \@entries;
}

__PACKAGE__->meta->make_immutable;

1;
