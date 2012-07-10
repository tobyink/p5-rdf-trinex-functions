use Test::More tests => 5;

use RDF::Trine;
use RDF::TrineX::Functions
	parse     => {},
	serialize => { -type => RDF::Trine::Serializer::NTriples::Canonical->new };

my %in;
($in{filename} = __FILE__) =~ s/t$/nt/;
open $in{filehandle}, '<', $in{filename} or die "Could not open $in{filename}: $!";
$in{data} = do { local (@ARGV, $/) = $in{filename}; <> };
open $in{datahandle}, '<', \($in{data});

foreach my $source (qw(data datahandle filename filehandle))
{
	my $model = parse(
		$in{$source},
		as   => 'NTriples',
		base => 'http://example.net/',
	);

	is($model->count_statements, 1, "parse(<$source>) OK");
	
	if ($source eq 'filehandle')
	{
		my $out      = serialize($model);
		my $expected = $in{data};
		for ($out, $expected) { s/[\r\n]//g };
		is($out, $expected, "serialize OK");
	}
}
