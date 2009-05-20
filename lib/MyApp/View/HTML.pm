package MyApp::View::HTML;

use Moose;
extends 'Catalyst::View';
use Text::MicroTemplate;
use Path::Extended;

sub process {
    my ($self, $c) = @_;

    my $output = $self->render($c);
    $c->res->body($output);
    $c->res->content_type('text/html');
}

sub render {
    my ($self, $c) = @_;

    my $file = $c->stash->{template} || 'default';
    my $template = file('template', $file)->slurp;
    my $engine = Text::MicroTemplate->new(
        line_start => '%',
        tag_start  => '<%',
        tag_end    => '%>',
        template   => $template,
    );
    return $engine->build->($self, $c)->as_string;
}

__PACKAGE__->meta->make_immutable;

1;
