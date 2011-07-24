package WebService::Simple::Yahoo::JP::API;

use strict;
use warnings;
use URI;
use base qw(WebService::Simple);
our $VERSION = '0.07';
__PACKAGE__->config(
		base_url => 'http://yahooapis.jp/',
		);

sub config
{
	my $class    = shift;
	my %args     = @_;
	my $self = $class->SUPER::config(%args);
	return $self;	
}

sub new
{
	my $class    = shift;
	my %args     = @_;
	my $self = $class->SUPER::new(%args);
	$self->{appid} = $args{appid};
	return $self;	
}

sub search     { return shift->_class('::Search'); }
sub map        { return shift->_class('::Map'); }
sub jlp        { return shift->_class('::Jlp'); }
sub auctions   { return shift->_class('::Auctions'); }
sub shopping   { return shift->_class('::Shopping'); }
sub news       { return shift->_class('::News'); }
sub chiebukuro { return shift->_class('::Chiebukuro'); }
sub dir        { return shift->_class('::Dir'); }
sub cert       { return shift->_class('::Cert'); }

sub _class
{
	my $self = shift;
	my $subclass = shift;
	my $class = ref $self;
	my $superclass = __PACKAGE__;
	if ($class =~ m/\A$superclass/) {
		return bless $self, __PACKAGE__.$subclass; 
	} else {
		return $self;
	}
}

sub _get
{
	my $self = shift;
	my $extra_path = shift;
	my $uri = URI->new($self->config->{base_url}.$extra_path);
	if ($self->{appid}) {
		$uri->query_form({appid => $self->{appid}, @_}) ;
	} else {
		$uri->query_form({@_}) ;
	}
	local $self->{base_url} = $uri;
	return $self->get('');
}

sub _post
{
	my $self = shift;
	my $extra_path = shift;
	local $self->{base_url} = $self->config->{base_url};
	if ($self->{appid}) {
		return $self->post($extra_path, Content => {appid => $self->{appid}, @_});
	} else {
		return $self->post($extra_path, Content => {@_});
	}
}

1;
__END__

=head1 NAME

WebService::Simple::Yahoo::JP::API - Simple Interface to Yahoo! JAPAN Web APIs

=head1 SYNOPSIS

  use Data::Dumper;
  use WebService::Simple::Parser::XML::Simple;
  use XML::Simple;
  use WebService::Simple::Yahoo::JP::API;
  use WebService::Simple::Yahoo::JP::API::Search;
  my $xs = XML::Simple->new( KeyAttr => [], ForceArray => ['Result'] );
  my $appid = 'hY5jLiqxg667n_2_Ho0Q6L_tRQWDeZT93fTG234MEQUk_eIfu7Q7_Uv48dZB';
  my $api = WebService::Simple::Yahoo::JP::API->new(
  appid => $appid,
  response_parser => WebService::Simple::Parser::XML::Simple->new(xs => $xs),
  );
  my $res = $api->search->websearch(query => "Perl");
  print Dumper $res;

=head1 DESCRIPTION

WebService::Simple::Yahoo::JP::API module provides an interface to the
Yahoo! JAPAN Web APIs (Search, Map, Jlp, Auctions, Shopping, News,
Chiebukuro, Dir, Cert).

=head1 METHODS

=over

=item new()

Create and return a new WebService::Simple::Yahoo::JP::API object.
"new" Method requires an application ID of Yahoo developper network.

=back

=head2 SUBCLASSING METHODS

=over

=item search()

Change WebService::Simple::Yahoo::JP::API or WebService::Simple::Yahoo::JP::API::I<hoge>
class to WebService::Simple::Yahoo::JP::API::Search class.

=item map()

Change WebService::Simple::Yahoo::JP::API or WebService::Simple::Yahoo::JP::API::I<hoge>
class to WebService::Simple::Yahoo::JP::API::Map class.

=item jlp()

Change WebService::Simple::Yahoo::JP::API or WebService::Simple::Yahoo::JP::API::I<hoge>
class to WebService::Simple::Yahoo::JP::API::Jlp class.

=item auctions()

Change WebService::Simple::Yahoo::JP::API or WebService::Simple::Yahoo::JP::API::I<hoge>
class to WebService::Simple::Yahoo::JP::API::Auctions class.

=item shopping()

Change WebService::Simple::Yahoo::JP::API or WebService::Simple::Yahoo::JP::API::I<hoge>
class to WebService::Simple::Yahoo::JP::API::Shopping class.

=item news()

Change WebService::Simple::Yahoo::JP::API or WebService::Simple::Yahoo::JP::API::I<hoge>
class to WebService::Simple::Yahoo::JP::API::News class.

=item chiebukuro()

Change WebService::Simple::Yahoo::JP::API or WebService::Simple::Yahoo::JP::API::I<hoge>
class to WebService::Simple::Yahoo::JP::API::Chiebukuro class.

=item dir()

Change WebService::Simple::Yahoo::JP::API or WebService::Simple::Yahoo::JP::API::I<hoge>
class to WebService::Simple::Yahoo::JP::API::Dir class.

=item cert()

Change WebService::Simple::Yahoo::JP::API or WebService::Simple::Yahoo::JP::API::I<hoge>
class to WebService::Simple::Yahoo::JP::API::Cert class.

=back

=head1 AUTHOR

AYANOKOUZI, Ryuunosuke E<lt>i38w7i3@yahoo.co.jpE<gt>

=head1 SEE ALSO

L<WebService::Simple::Yahoo::JP::API::Search>

L<WebService::Simple::Yahoo::JP::API::Map>

L<WebService::Simple::Yahoo::JP::API::Jlp>

L<WebService::Simple::Yahoo::JP::API::Auctions>

L<WebService::Simple::Yahoo::JP::API::Shopping>

L<WebService::Simple::Yahoo::JP::API::News>

L<WebService::Simple::Yahoo::JP::API::Chiebukuro>

L<WebService::Simple::Yahoo::JP::API::Dir>

L<WebService::Simple::Yahoo::JP::API::Cert>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
