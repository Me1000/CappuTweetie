@implementation TwitterAPIController : CPObject
{
    id searchConnection;
    id tweetConnection;

    BOOL loadingMore @accessors;

    int normalTweetPage;
    int searchTweetPage;

    BOOL normalTweetCanLoadMore;
    BOOL searchTweetCanLoadMore;

    CPString currentSearchString @accessors;
}

- (id)init
{
    self = [super init];

    loadingMore = NO;
    normalTweetCanLoadMore = YES;
    searchTweetCanLoadMore = YES;
    normalTweetPage = 0;
    searchTweetPage = 0;

    return self;
}

- (void)getTweets
{
    if (tweetConnection || !normalTweetCanLoadMore)
        return;

    normalTweetPage++;

    /*var getData = new CFHTTPRequest();

    getData.open("GET", [[CPBundle mainBundle] pathForResource:"data.json"], true);
    getData.oncomplete = function()
    {
        if (getData.success())
        {
            var data = JSON.parse(getData.responseText());
            [[[CPApp delegate] tweetController] setContent:data];

            // FIX ME: this is terrible
            [[CPApp delegate].tweetTable setIsLoading:NO];
            [[CPApp delegate].tweetTable reloadData];
        }

        [[CPRunLoop currentRunLoop] performSelectors];
    }

    getData.send("");*/


    var lastTweet = "&page="+normalTweetPage;

    var query = escape("githubissues");

    var request = [[CPURLRequest alloc] initWithURL:"http://search.twitter.com/search.json?&q="+query+"&show_user=true&rpp=20&page="+normalTweetPage];
    [request setHTTPMethod:@"GET"];
    tweetConnection = [CPJSONPConnection sendRequest:request callback:"callback" delegate:self];
    [[[CPApp delegate] activeTV] setIsLoading:YES];
}

- (void)searchForString:(CPString)aString
{

    if (searchConnection || !searchTweetCanLoadMore)
        return;

    if (aString !== currentSearchString)
        searchTweetPage = 1;
    else
        searchTweetPage++;

    currentSearchString = aString;


    var lastTweet = "&page="+searchTweetPage;
    var query = escape(aString);


    var request = [[CPURLRequest alloc] initWithURL:"http://search.twitter.com/search.json?&q="+query+"&show_user=true&rpp=20&page="+searchTweetPage];
    [request setHTTPMethod:@"GET"];
    searchConnection = [CPJSONPConnection sendRequest:request callback:"callback" delegate:self];
    [[[CPApp delegate] activeTV] setIsLoading:YES];
}

- (void)connection:(CPURLConnection)aConnection didReceiveData:(JSObject)data
{
    if (aConnection === searchConnection)
    {
        [[[CPApp delegate] searchController] addObjects:data.results];

        if (data.results.length < 20)
            searchTweetCanLoadMore = NO;
    }
    else
    {
        [[[CPApp delegate] tweetController] addObjects:data.results];

        if (data.results.length < 20)
            normalTweetCanLoadMore = NO;
    }

    [[[CPApp delegate] activeTV] setIsLoading:NO];
    [[[CPApp delegate] activeTV] reloadData];

    if (aConnection === searchConnection)
        searchConnection = nil;
    else
        tweetConnection = nil;


}

@end

