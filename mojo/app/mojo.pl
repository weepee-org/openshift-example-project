#!/usr/bin/perl
#
# The weepee routing lookup rest service

use v5.10;
use strict;
use utf8;
use Mojolicious::Lite;
use Mojo::JSON qw(decode_json);
use Sys::Hostname;

get '/' => sub {
  my $self = shift;
  if ($self->req->headers->header('X-Forwarded-SSL') ne 'on') {
    $self->render(text => 'this is a non encrypted example mojo page');
  } else {
    $self->render(text => 'this is an encrypted example mojo page');
  }
};

app->start;
