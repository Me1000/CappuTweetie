@implementation TwitterAPIController : CPObject
{
    id searchConnection;

    BOOL loadingMore @accessors;

    int normalTweetLimit;
    int searchTweetLimit;

    CPString currentSearchString @accessors;
}

- (id)init
{
    self = [super init];

    loadingMore = NO;
    normalTweetLimit = 0;
    searchTweetLimit = 0;

    return self;
}

- (void)getTweets
{
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


    var lastTweet = [[[[CPApp delegate] tweetController] contentArray] count] ? "&since_id=" + [[[[CPApp delegate] tweetController] contentArray] lastObject].id_str : "";

    var query = escape("githubissues" + lastTweet);
    
    var request = [[CPURLRequest alloc] initWithURL:"http://search.twitter.com/search.json?&q="+query+"&show_user=true"];
    [request setHTTPMethod:@"GET"];
    tweetConnection = [CPJSONPConnection sendRequest:request callback:"callback" delegate:self];
    [[[CPApp delegate] activeTV] setIsLoading:YES];
}

- (void)searchForString:(CPString)aString
{
currentSearchString = aString;
    var lastTweet = [[[[CPApp delegate] searchController] contentArray] count] ? "&since_id=" + [[[[CPApp delegate] searchController] contentArray] lastObject].id_str : "";
    var query = escape(aString + lastTweet);
    
    var request = [[CPURLRequest alloc] initWithURL:"http://search.twitter.com/search.json?&q="+query+"&show_user=true"];
    [request setHTTPMethod:@"GET"];
    searchConnection = [CPJSONPConnection sendRequest:request callback:"callback" delegate:self];
    [[[CPApp delegate] activeTV] setIsLoading:YES];
}

- (void)connection:(CPURLConnection)aConnection didReceiveData:(JSObject)data
{
    if (aConnection === searchConnection)
        [[[CPApp delegate] searchController] addObjects:data.results];
    else
        [[[CPApp delegate] tweetController] addObjects:data.results];

    [[[CPApp delegate] activeTV] setIsLoading:NO];
    [[[CPApp delegate] activeTV] reloadData];
}

@end

