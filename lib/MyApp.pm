package MyApp;

use Moose;
use Catalyst::Runtime 5.80;
extends 'Catalyst';

our $VERSION = '0.01';

__PACKAGE__->setup_home;
__PACKAGE__->setup;

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

MyApp - sample application for http://gihyo.jp/dev/serial/01/modern-perl/0007

=head1 SYNOPSIS

    script/myapp_server.pl

=head1 SEE ALSO

L<Catalyst::Runtime>, L<Catalyst::Manual>

=head1 AUTHOR

Kenichi Ishigaki (ishigaki@cpan.org)

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
