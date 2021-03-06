#!/usr/bin/env perl
use strict;
use warnings;
use File::Copy;
use autodie;

# https://github.com/dbbolton/ 

print "'cp' for copy or 'ul' for upload\n" unless @ARGV;

for (@ARGV) {
    &cp if /^cp$/;
    &ul if /^ul$/;
}

sub cp {
    print "Gathering files...\n";

    my $h    = $ENV{HOME};
    my $cfg  = ".config";
    my $ob   = "openbox";
    my $dest = "$h/src/github/configs";

    my %files = (
        "$cfg/$ob/autostart.sh"   => "openbox-autostart.sh",
        "$cfg/$ob/menu.xml"       => "openbox-menu.xml",
        "$cfg/$ob/rc.xml"         => "openbox-rc.xml",

		".perltidyrc"		=> "perltidyrc",
        ".screenrc"          => "screenrc",
        "$cfg/tint2/tint2rc" => "tint2rc",
        ".vimrc"             => "vimrc",
        ".Xresources"         => "Xresources",

        ".zshrc"      => "zshrc",
        ".zaliases"   => "zaliases",
        ".zshenv"     => "zshenv",
        ".zfunctions" => "zfunctions",
    );

    while ( my ( $key, $value ) = each %files ) {
        print "$h/$key ->\n $dest/$value\n";
        copy( "$h/$key", "$dest/$value" );
    }

} # end &cp

sub ul {
    system "git add ./*";
    system "git commit -m 'update everything'";
    system "git push origin master";
} # end &ul

