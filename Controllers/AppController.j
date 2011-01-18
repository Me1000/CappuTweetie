@import <Foundation/CPObject.j>
@import "../Views/TweetDataView.j"
@import "TwitterAPIController.j"
@import <Foundation/CPDate.j>
@import <AppKit/CPScroller.j>
@import <AppKit/CPTableView.j>
@import <AppKit/CPScrollView.j>
@import <Foundation/CPTimer.j>
@import <AppKit/CPSegmentedControl.j>
@import "../Views/NewTweetWindow.j"
@import "../Views/TwitterWindow.j"
@import "../Views/SidebarView.j"
@import "../Views/BreadcrumbView.j"
@import "../Views/TweetScroller.j"
@import "../Views/TweetTableView.j"
@import "../Views/PreferencesWindow.j"

@import "AccountController.j"
@import "../Models/TwitterAccount.j"

accountsController = [[AccountController alloc] init];

@implementation AppController : CPObject
{
    CPScrollView tweetScrollView;
    CPTableView  tweetTable;
    CPTableColumn tweetsColumn;
    CPTextField cachedTextField;

    CPArrayController tweetController @accessors;
    CPWindow preferencesWindow;
    SidebarView sidebar @accessors;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMake(100,100,405,585) styleMask:CPClosableWindowMask|CPMiniaturizableWindowMask],
        contentView = [theWindow contentView],
        bgColor = [CPColor colorWithRed:210/255 green:210/255 blue:210/255 alpha:1];

    [theWindow _setWindowView:[[TwitterWindow alloc] initWithFrame:[theWindow._windowView frame] styleMask:CPClosableWindowMask|CPMiniaturizableWindowMask]];
    [theWindow setMovableByWindowBackground:YES];
    [contentView setBackgroundColor:bgColor];
    
    // Menubar... not sure I like it, but I had to put preferences somewhere...
    var mainMenu = [[CPMenu alloc] initWithTitle:"main"],
        menu = [[CPMenu alloc] initWithTitle:"CappuTweetie"];
        
    var item = [mainMenu addItemWithTitle:"CappuTweetie" action:nil keyEquivalent:nil];
    [menu addItemWithTitle:"Preferences..." action:@selector(showPreferencesWindow:) keyEquivalent:","];
    [mainMenu setSubmenu:menu forItem:item];

    var item = [[CPMenuItem alloc] initWithTitle:"Quit CappuTweetie" action:@selector(terminate:) keyEquivalent:"q"];
    [item setTarget:CPApp];
    [menu addItem:item];
    
    var item = [mainMenu addItemWithTitle:"File" action:nil keyEquivalent:nil],
        fileMenu = [[CPMenu alloc] initWithTitle:"File"];
        
    [fileMenu addItemWithTitle:"New Tweet..." action:@selector(newTweet:) keyEquivalent:"n"];
    [mainMenu setSubmenu:fileMenu forItem:item];
    
    var editMenuItem = [mainMenu addItemWithTitle:"Edit" action:nil keyEquivalent:nil],
            editMenu = [[CPMenu alloc] initWithTitle:"Edit"];
            
    [editMenu addItemWithTitle:"Cut" action:@selector(cut:) keyEquivalent:"x"];
    [editMenu addItemWithTitle:"Copy" action:@selector(copy:) keyEquivalent:"c"];
    [editMenu addItemWithTitle:"Paste" action:@selector(paste:) keyEquivalent:"v"];
    [editMenu addItemWithTitle:"Select All" action:@selector(selectAll:) keyEquivalent:"a"];
    
    [editMenuItem setSubmenu:editMenu];
        
    // set & make visible 
    [CPApp setMainMenu:mainMenu];
    [CPMenu setMenuBarVisible:YES]; 

    // Breadcrumbs...
    var breadcrumbs = [[BreadcrumbView alloc] initWithFrame:CGRectMake(60,0,345,27)];
    [breadcrumbs addItem:"Timeline"];
    [breadcrumbs addItem:"Me1000"];
    [breadcrumbs addItem:"devongovett"];
    [breadcrumbs addItem:"Tolmasky"];

    [contentView addSubview:breadcrumbs];

    // Sidebar...
    sidebar = [[SidebarView alloc] initWithFrame:CGRectMake(0, 0, 60, 585)];
    [contentView addSubview:sidebar];

    tweetScrollView = [[CPScrollView alloc] initWithFrame:CGRectMake(60, 27, 340, 535)];
    
    // Main tweet tableview...
    // we can make this size zero because it will be sized to fit when we add it to the scrollview.
    tweetTable = [[TweetTableView alloc] initWithFrame:CGRectMakeZero()];
    [tweetTable setDelegate:self];
    [tweetTable setBackgroundColor:bgColor];
    [tweetTable setDoubleAction:@selector(didDoubleClick:)];
    [tweetTable setTarget:self];
    [tweetTable setColumnAutoresizingStyle:CPTableViewLastColumnOnlyAutoresizingStyle];

    // Load tweets...
    tweetController = [[CPArrayController alloc] init];
    apiController = [[TwitterAPIController alloc] init];
    [apiController getTweets];
    
    tweetsColumn = [[CPTableColumn alloc] initWithIdentifier:"tweets"];
    [tweetsColumn setWidth:322];
    [tweetTable addTableColumn:tweetsColumn];
    [tweetsColumn bind:CPValueBinding toObject:tweetController withKeyPath:"arrangedObjects" options:nil];

    var dataViewPrototype = [[TweetDataView alloc] initWithFrame:CGRectMake(0,0,322,100)];
    [tweetsColumn setDataView:dataViewPrototype];
    
    // Custom scrolling....
    var newScroller = [[TweetScroller alloc] initWithFrame:CGRectMake(0,0,11,100)];
    [tweetScrollView setHasHorizontalScroller:NO];
    [tweetScrollView setVerticalScroller:newScroller];
    [tweetScrollView setDocumentView:tweetTable];

    [contentView addSubview:tweetScrollView];
    
    // Bottom toolbar
    var toolbar = [[CPView alloc] initWithFrame:CGRectMake(0, 562, 405, 23)],
        bg = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"toolbar.png"]];

    [toolbar setBackgroundColor:[CPColor colorWithPatternImage:bg]];
    
    // Compose button...
    var composeImage = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"SmallCompose.png"] size:CGSizeMake(14, 13)],
        composeImageActive = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"SmallComposeActive.png"] size:CGSizeMake(14, 13)],
        composeButton = [[CPButton alloc] initWithFrame:CGRectMake(9, 6, 14, 13)];

    [composeButton setBordered:NO];
    [composeButton setImage:composeImage];
    [composeButton setAlternateImage:composeImageActive];
    [composeButton setTarget:self];
    [composeButton setAction:@selector(newTweet:)];
    [toolbar addSubview:composeButton];
    
    [contentView addSubview:toolbar];
    
    [accountsController addAccount:[TwitterAccount accountWithUsername:"devongovett" password:"password"]];
    [accountsController addAccount:[TwitterAccount accountWithUsername:"me1000" password:"password"]];
    [theWindow orderFront:self];
    
    preferencesWindow = [[PreferencesWindow alloc] init];
}

- (void)newTweet:(id)sender
{
    var tweetWindow = [[NewTweetWindow alloc] initWithTweetReply:""];
    [tweetWindow makeKeyAndOrderFront:self];
}

- (void)showPreferencesWindow:(id)sender
{
	[preferencesWindow orderFront:self];
}

- (void)loadMoreTweets
{
    //alert("LOAD MOAR");
}

- (CPMenu)tableView:(CPTableView)aTableView menuForTableColumn:(CPTableColumn)aColumn row:(int)aRow
{
    var menuItems = ["Reply...", "Retweet...", "Quote Tweet...", "Copy Link to Tweet", CPNotFound, "Direct Message...", CPNotFound, "Mark As Favorite", CPNotFound, "Open in Browser"],
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

    return MAX(65, [cachedTextField frame].size.height + 35);
}

- (void)didDoubleClick:(id)sender
{
    // FIX ME: Add delegate: when animation finishes close the window. 
    // Figure out what we double clicked on... if there is a reply load that reply chain all the way back,
    // otherwise place that tweet in its own array and load it into the controller...
    // Also, create a new tableview (or have a 2nd one already qued up) which we load the new content to.

    var sender = [[sender superview] superview],
        convertedPoint = [[sender window] convertBaseToGlobal:[sender convertPoint:[sender frame].origin toView:nil]];
        newWindowRect = CGRectMake(convertedPoint.x - 100, convertedPoint.y - 100, [sender frame].size.width + 200, [sender frame].size.height + 200),
        startRect = CGRectMake(40, 73, [sender frame].size.width, [sender frame].size.height),
        endRect =  CGRectMake(30, 63, [sender frame].size.width + 20, [sender frame].size.height + 20),




    var newWindow = [[CPWindow alloc] initWithContentRect:newWindowRect styleMask:CPBorderlessWindowMask];

    [newWindow orderFront:self];
    [[newWindow contentView] addSubview:sender];


    var dict = [CPDictionary dictionaryWithObjects:[sender, startRect, endRect, CPViewAnimationFadeOutEffect]
                                           forKeys:[CPViewAnimationTargetKey, CPViewAnimationStartFrameKey, CPViewAnimationEndFrameKey, CPViewAnimationEffectKey]];

    var ani = [[CPViewAnimation alloc] initWithViewAnimations:[dict]];
    [ani setDuration:.1];

    [ani startAnimation];
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