#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Getopt::Long qw(GetOptions :config no_auto_abbrev no_ignore_case);

GetOptions(
  'f|foreground' => sub { $ENV{HYPNOTOAD_FOREGROUND} = 1 },
  'h|help'       => \my $help,
  's|stop'       => sub { $ENV{HYPNOTOAD_STOP}       = 1 },
  't|test'       => sub { $ENV{HYPNOTOAD_TEST}       = 1 }
);

die <<"EOF" if $help || !(my $app = shift || $ENV{HYPNOTOAD_APP});
usage: $0 [OPTIONS] [APPLICATION]

  hypnotoad script/myapp
  hypnotoad myapp.pl
  hypnotoad -f myapp.pl

These options are available:
  -f, --foreground   Keep manager process in foreground.
  -h, --help         Show this message.
  -s, --stop         Stop server gracefully.
  -t, --test         Test application and exit.
EOF

require Mojo::Server::Hypnotoad;
Mojo::Server::Hypnotoad->new->run($app);

=head1 NAME

hypnotoad - Hypnotoad HTTP and WebSocket server

=head1 SYNOPSIS

  $ hypnotoad --help
  $ hypnotoad myapp.pl

=head1 DESCRIPTION

Start L<Mojolicious> and L<Mojolicious::Lite> applications with the
L<Mojo::Server::Hypnotoad> web server.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut