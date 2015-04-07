package DDG::Spice::Guidebox::Getid;

use strict;
use DDG::Spice;

primary_example_queries "guidebox Castle";
description "Search for full free episodes of all your favorite TV shows (USA only)";
name "Guidebox";
code_url "https://github.com/duckduckgo/zeroclickinfo-spice/blob/master/lib/DDG/Spice/Guidebox/Getid.pm";
icon_url "/i/www.guidebox.com.ico";
topics "everyday", "entertainment", "social";
category "entertainment";
attribution github => ['https://github.com/adman','Adman'],
            twitter => ['http://twitter.com/adman_X','Adman'];

triggers startend => "guidebox";

spice to => 'http://api-public.guidebox.com/v1.3/json/{{ENV{DDG_SPICE_GUIDEBOX_APIKEY}}}/search/title/$1';
spice wrap_jsonp_callback => 1;

my %skip = map { $_ => 0 } (
    'watchmen',
    'movie',
    'movies',
    'series',
    'shows'
);

handle remainder => sub {
    return unless ($loc->country_name eq "United States" || $loc->country_name eq "Canada");
    return unless $_ && exists $skip->{$_};
    return $_;
};

1;
