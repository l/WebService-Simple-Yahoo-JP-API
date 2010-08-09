package WebService::Simple::Yahoo::JP::API;

use strict;
use warnings;
use URI;
use base qw(WebService::Simple);
our $VERSION = '0.01';
__PACKAGE__->config(
		base_url => 'http://yahooapis.jp/',
		);

sub new
{
	my $class    = shift;
	my %args     = @_;
	my $self = $class->SUPER::new(%args);
	$self->{appid} = $args{appid};
	return $self;	
}

sub search      { return bless shift, __PACKAGE__.'::Search'; }
sub map         { return bless shift, __PACKAGE__.'::Map'; }
sub jlp         { return bless shift, __PACKAGE__.'::Jlp'; }
sub auctions    { return bless shift, __PACKAGE__.'::Auctions'; }
sub shopping    { return bless shift, __PACKAGE__.'::Shopping'; }
sub news        { return bless shift, __PACKAGE__.'::News'; }
sub chiebukuro  { return bless shift, __PACKAGE__.'::Chiebukuro'; }
sub dir         { return bless shift, __PACKAGE__.'::Dir'; }
sub cert        { return bless shift, __PACKAGE__.'::Cert'; }

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

WebService::Simple::Yahoo::JP::API -

=head1 SYNOPSIS

  use WebService::Simple::Yahoo::JP::API;

=head1 DESCRIPTION

WebService::Simple::Yahoo::JP::API is

=head1 AUTHOR

AYANOKOUZI, Ryuunosuke E<lt>i38w7i3@yahoo.co.jpE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
