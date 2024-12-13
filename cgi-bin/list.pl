#!/usr/bin/perl
use strict;
use warnings;
use CGI qw(:standard);
use File::Slurp;

# Ruta donde se almacenan las páginas en formato Markdown
my $data_dir = "../data";

print header(-charset => 'UTF-8');
print start_html(-title => 'Nuestras páginas de wiki',
                 -style => {'src' => '../styles/style.css'});

print h1("Nuestras páginas de wiki");

# Mostrar lista de páginas
opendir(my $dh, $data_dir) or die "No se pudo abrir el directorio $data_dir: $!";
my @files = grep { /\.md$/ && -f "$data_dir/$_" } readdir($dh);
closedir($dh);

if (@files) {
    print "<ul>\n";
    foreach my $file (@files) {
        (my $title = $file) =~ s/\.md$//;
        print "<li><a href='view.pl?title=$title'>$title</a> ";
        print "<a href='edit.pl?title=$title'>[E]</a> ";
        print "<a href='delete.pl?title=$title'>[X]</a></li>\n";
    }
    print "</ul>\n";
} else {
    print p("No hay páginas disponibles.");
}

# Botón para crear una nueva página
print p(a({-href => "new.html"}, "Nueva Página"));

# Enlace para volver al inicio
print p(a({-href => "../index.html"}, "Volver al Inicio"));

print end_html;
