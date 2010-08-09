package WebService::Simple::Yahoo::JP::API::Search;
use base qw(WebService::Simple::Yahoo::JP::API);
__PACKAGE__->config(
		base_url => 'http://search.yahooapis.jp/',
		);

sub websearch { shift->_post('WebSearchService/V1/webSearch', @_); }
sub imagesearch { shift->_post('ImageSearchService/V1/imageSearch', @_); }
sub videosearch { shift->_post('VideoSearchService/V1/videoSearch', @_); }
sub webunitsearch { shift->_post('AssistSearchService/V1/webunitSearch', @_); }
sub blogsearch { shift->_get('BlogSearchService/V1/blogSearch', @_); }
1;
