@implementation TwitterAPIController : CPObject
{

}

- (void)getTweets
{
    var getData = new CFHTTPRequest();

    getData.open("GET", [[CPBundle mainBundle] pathForResource:"data.json"], true);
    getData.oncomplete = function()
    {
        if (getData.success())
        {
            var data = JSON.parse(getData.responseText());
            [[[CPApp delegate] tweetController] setContent:data];

            // FIX ME: this is terrible
            [[CPApp delegate].tweetTable setIsLoading:NO];
        }

        [[CPRunLoop currentRunLoop] performSelectors];
    }

    getData.send("");
}

- (void)searchForString:(CPString)aString
{
    var query = escape(aString);
    
    var request = [[CPURLRequest alloc] initWithURL:"http://search.twitter.com/search.json?&q="+query+"&show_user=true"];
    [request setHTTPMethod:@"GET"];
    var connection = [CPJSONPConnection sendRequest:request callback:"callback" delegate:self];
}

- (void)connection:(CPURLConnection)aConnection didReceiveData:(JSObject)data
{    
    [[[CPApp delegate] searchController] setContent:data.results];
    
    // FIX ME: this is terrible
    [[CPApp delegate].searchTable setIsLoading:NO];
    
    [[CPRunLoop currentRunLoop] performSelectors];
}

@end

