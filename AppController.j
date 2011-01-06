@import <Foundation/CPObject.j>
@import "TweetDataView.j"
@import "TwitterAPIController.j"
@import <Foundation/CPDate.j>

@implementation AppController : CPObject
{
    CPScrollView tweetScrollView;
    CPTableView  tweetTable;
    CPTableColumn tweetsColumn;

    CPTextField cachedTextField;

    CPArrayController tweetController @accessors;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMake(100,100,345,585) styleMask:CPBorderlessBridgeWindowMask|CPClosableWindowMask|CPMiniaturizableWindowMask],
        contentView = [theWindow contentView],
        bgColor = [CPColor colorWithRed:210/255 green:210/255 blue:210/255 alpha:1];

    [contentView setBackgroundColor:bgColor];

    tweetScrollView = [[CPScrollView alloc] initWithFrame:CGRectMake(0,0, 340, 585)];
    // we can make this size zero because it will be sized to fit when we add it to the scrollview.
    tweetTable = [[CPTableView alloc] initWithFrame:CGRectMakeZero()];

    [tweetTable setDelegate:self];

    [tweetTable setBackgroundColor:bgColor];
    [tweetTable setHeaderView:nil];
    [tweetTable setCornerView:nil];
    
    tweetController = [[CPArrayController alloc] init];
    apiController = [[TwitterAPIController alloc] init];
    [apiController getTweets];


    [tweetTable setSelectionHighlightColor:[CPColor colorWithRed:241/255 green:241/255 blue:241/255 alpha:1]];

    tweetsColumn = [[CPTableColumn alloc] initWithIdentifier:"tweets"];
    [tweetsColumn setWidth:322];
    [tweetTable addTableColumn:tweetsColumn];
    [tweetsColumn bind:CPValueBinding toObject:tweetController withKeyPath:"arrangedObjects" options:nil];

    var dataViewPrototype = [[TweetDataView alloc] initWithFrame:CGRectMake(0,0,322,100)];
    [tweetsColumn setDataView:dataViewPrototype];


    var newScroller = [[CPScroller alloc] initWithFrame:CGRectMake(0,0,11,100)],
        scrollerColor = [CPColor colorWithPatternImage:[[CPThreePartImage alloc] initWithImageSlices:[
            [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"scroller/scroller_0.png"] size:CGSizeMake(11, 5)],
            [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"scroller/scroller_1.png"] size:CGSizeMake(11, 2)],
            [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"scroller/scroller_2.png"] size:CGSizeMake(11, 5)]
        ] isVertical:YES]];

    [newScroller setValue:scrollerColor forThemeAttribute:"knob-color"];
    [newScroller setValue:bgColor forThemeAttribute:"knob-slot-color"];
    [newScroller setValue:bgColor forThemeAttribute:"increment-line-color"];
    [newScroller setValue:bgColor forThemeAttribute:"decrement-line-color"];
    [newScroller setValue:CGSizeMake(11,15) forThemeAttribute:"decrement-line-size"];
    [newScroller setValue:CGSizeMake(11,15) forThemeAttribute:"increment-line-size"];


    [tweetScrollView setVerticalScroller:newScroller];
    [tweetScrollView setDocumentView:tweetTable];
    [tweetScrollView setHasHorizontalScroller:NO];

    [contentView addSubview:tweetScrollView];

    [theWindow orderFront:self];
}

- (CPMenu)tableView:(CPTableView)aTableView menuForTableColumn:(CPTableColumn)aColumn row:(int)aRow
{
    var menuItems = ["Reply...", "Repost...", "Copy Link to Tweet", CPNotFound, "Direct Message...", CPNotFound, "Mark As Favorite", CPNotFound, "Open in Browser"],
        i = 0,
        c = menuItems.length,
        menu = [[CPMenu alloc] initWithTitle:""];

    for (; i < c; i++)
    {
        var title = menuItems[i];

        if (title === CPNotFound)
            [menu addItem:[CPMenuItem separatorItem]];
        else
            [menu addItem:[[CPMenuItem alloc] initWithTitle:menuItems[i] action:nil keyEquivalent:nil]];
    }

    return menu;
}

- (int)tableView:(CPTableView)aTableView heightOfRow:(int)aRow
{
    //debugger;
    console.log(aRow);
    // To calculate the height of the row we find the width of the column
    var width = [tweetsColumn width];

    if (!cachedTextField)
    {
        cachedTextField = [[CPTextField alloc] initWithFrame:CGRectMake(0, 0, width - 100, 20)];
        [cachedTextField setLineBreakMode:CPLineBreakByWordWrapping];
        [cachedTextField setFont:[CPFont systemFontOfSize:13]];
    }

    // we have to make sure the width of the textfield is correct...
    [cachedTextField setFrame:CGRectMake(0, 0, width - 100, 0)];

    [cachedTextField setStringValue:[tweetController contentArray][aRow].text];
    [cachedTextField sizeToFit];

    return [cachedTextField frame].size.height + 35;
}

@end

@implementation CPTableView (foo)
- (void)noteHeightOfRowsWithIndexesChanged:(CPIndexSet)anIndexSet
{
//    if (!(_implementedDelegateMethods & CPTableViewDelegate_tableView_heightOfRow_))
  //      return;

    // this method will update the height of those rows, but since the cached array also contains
    // the height above the row it needs to recalculate for the rows below it too
    var i = [anIndexSet firstIndex],
        count = _numberOfRows - i,
        heightAbove = (i > 0) ? _cachedRowHeights[i - 1].height + _cachedRowHeights[i - 1].heightAboveRow + _intercellSpacing.height : 0;

    for (; i < count; i++)
    {
        // update the cache if the user told us to
        if ([anIndexSet containsIndex:i])
            var height = [_delegate tableView:self heightOfRow:i];

            _cachedRowHeights[i] = {"height":height, "heightAboveRow":heightAbove};

        heightAbove += height + _intercellSpacing.height;
    }

    [self setNeedsLayout];
    //_reloadAllRows = YES;
    //[self load];
    //[self reloadData]; //!!!!!!!!

    [self _layoutDataViewsInRows:[CPIndexSet indexSetWithIndexesInRange:CPMakeRange(0,[self numberOfRows]-1)] columns:[CPIndexSet indexSetWithIndexesInRange:CPMakeRange(0,[self numberOfColumns]-1)]];
}
@end

OPEN_LINK = function(url)
{
    //is it an image?
    var imageTypes = ["jpg", "gif", "png"],
        isImage = [imageTypes containsObject:[url pathExtension]];

    if (isImage)
    {
        var mouseAt = [[CPApp currentEvent] globalLocation],
            location = CGRectMake(mouseAt.x, mouseAt.y, 25, 25),
            imageWindow = [[CPWindow alloc] initWithContentRect:location styleMask:CPTitledWindowMask|CPHUDBackgroundWindowMask|CPResizableWindowMask|CPClosableWindowMask],
            contentView = [imageWindow contentView],
            imageView = [[CPImageView alloc] initWithFrame:[contentView bounds]]
            finalFrame = CGRectMake(300,100, 500, 500);

        [imageView setImage:[[CPImage alloc] initWithContentsOfFile:url]];
        [imageView setImageScaling:CPScaleProportionally];
        [imageView setAutoresizingMask:CPViewHeightSizable|CPViewWidthSizable];

        [contentView addSubview:imageView];
        [imageWindow orderFront:self];
        [imageWindow setFrame:finalFrame display:YES animate:YES];
        return;
    }

    if ([CPPlatform isBrowser])
        window.open(url);
    else
        window.location = url;
}