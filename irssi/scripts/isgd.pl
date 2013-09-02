# isgd.pl
#
# URL shortening with is.gd or v.gd
#
# Copyright (c) 2010 Szymon 'polemon' Bereziak <polemon@polemon.org>
#
# This script is licensed untder ISC license
#

use strict;
use vars qw($VERSION %IRSSI);

use Irssi;
use XML::LibXML 1.70;

$VERSION = "1.2";

%IRSSI = (
         author => "Szymon 'polemon' Bereziak",
        contact => "polemon\@polemon.org",
           name => "is.gd",
    description => "URL shortening with is.gd",
        license => "ISC",
            url => "http://polemon.org/isgd.pl",
        changed => "2011-03-02",
);

Irssi::settings_add_int("isgd", "isgd_length", "14");
Irssi::settings_add_str("isdg", "isgd_site", "is.gd");
Irssi::signal_add_first("send text", "modline");
Irssi::signal_add_last("setup changed", "init");

my $ureg = qr{};
my $site = "";

&init;

sub init {
    my $i = Irssi::settings_get_int('isgd_length');
    $site = Irssi::settings_get_str('isgd_site');

    $ureg = qr{
      \b(
        (?:ht|f)tps?://\S{$i,}
      )\b
    }x;
}

sub modline {
    my ($line, $server, $witem) = @_;
    $line =~ s/$ureg/shorturl($1)/ige;

    Irssi::signal_continue($line, $server, $witem);
}

sub shorturl {
    local $SIG{'__WARN__'} = sub { };
    my ($url) = @_;
    $url =~ s/([^A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg;

    my $parser = XML::LibXML->new({"recover" => 2});
    my $doc = $parser->parse_html_file("http://$site/create.php?longurl=$url");

    if($doc->getElementById("short_url")) {
        return $doc->getElementById("short_url")->getAttribute("value");        
    }

    return "@_";
}
