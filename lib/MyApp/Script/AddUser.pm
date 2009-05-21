package MyApp::Script::AddUser;

use Moose;
extends 'CLI::Dispatch::Command';
use MyApp::Model::User;
use Carp;

sub options {qw( id|i=s name|n=s password|pass|p=s )}

sub run {
    my ($self, @args) = @_;

    croak "requires id"       unless defined $self->{id};
    croak "requires password" unless defined $self->{password};

    my $model = MyApp::Model::User->new;
    my $user = $model->_item($self->{id});

    croak "user exists" if $user->exists;

    $user->create({
        password => $self->{password},
        name     => $self->{name} || 'anonymous',
    });
}

1;

__END__

=head1 NAME

MyApp::Script::AddUser - add user

