#!/usr/bin/perl
use Mojolicious::Lite;

plugin i18n => {default => 'en', namespace => 'DrinkingGame::I18N'};

# /
get '/' => 'index';

#get '/favicon' => 'index';

app->start;

__DATA__

@@ index.html.ep
% layout 'index';
