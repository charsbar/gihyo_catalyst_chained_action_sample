use strict;
use warnings;
use Test::More tests => 9;
use Path::Extended;
use utf8;

use MyApp::Item::Entry;

my $file = file('t/tmp/entry');
my $body = 'テスト';

ok !$file->exists, "file does not exist";

my $entry = MyApp::Item::Entry->new(file => $file);

ok $entry->id eq 'entry', "id is correct";
ok !$entry->exists, "enty does not exist";
ok !$entry->body, "body is blank";

$entry->create({ body => $body, author => 'me' });

ok $entry->exists, "now entry does exist";
ok $entry->body eq $body, "body is correct";

$entry->clear;

$entry = MyApp::Item::Entry->new(file => $file);

ok $entry->exists, "now entry does exist";
ok $entry->id eq 'entry', "id is correct";
ok $entry->body eq $body, "body is correct";

$file->parent->remove;
