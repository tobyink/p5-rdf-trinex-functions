use Test::More tests => 2;

use RDF::Trine;
use RDF::TrineX::Functions
	parse     => {},
	serialize => { -type => RDF::Trine::Serializer::NTriples::Canonical->new };

my $in    = "<http://example.com/s> <http://example.com/p> <http://example.com/o> .\r\n";
my $model = parse($in, as => 'NTriples', base => 'http://example.net/');

is($model->count_statements, 1, "rdf_parse OK");

my $type;

is(serialize($model), $in, "rdf_string OK");
