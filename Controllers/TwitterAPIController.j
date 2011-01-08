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
        }

        [[CPRunLoop currentRunLoop] performSelectors];
    }

    getData.send("");
}
@end

