package WebService::Simple::Yahoo::JP::API::Jlp;
use base qw(WebService::Simple::Yahoo::JP::API);
__PACKAGE__->config(
		base_url => 'http://jlp.yahooapis.jp/',
		);

sub ma { shift->_post('MAService/V1/parse', @_); }
sub jim { shift->_post('JIMService/V1/conversion', @_); }
sub furigana { shift->_post('FuriganaService/V1/furigana', @_); }
sub kousei { shift->_post('KouseiService/V1/kousei', @_); }
sub da { shift->_post('DAService/V1/parse', @_); }
sub keyphrase { shift->_post('KeyphraseService/V1/extract', @_); }
1;
