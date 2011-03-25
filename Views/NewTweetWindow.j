@import "EditTweetTextView.j"

@implementation NewTweetWindow : CPWindow
{
    CPTextField charsLeftField;
    CPColor normalCharCountColor;
    CPColor warningCharCountColor;
    EditTweetTextView text;
}

- (id)initWithTweetReply:(JSObject)aTweet
{
    self = [super initWithContentRect:CGRectMake(100, 100, 400, 135) styleMask:CPTitledWindowMask|CPClosableWindowMask|CPMiniaturizableWindowMask];
    [self center];
    [self setMovableByWindowBackground:YES];
    [self setDelegate:self];
    
    if (self)
    {
        normalCharCountColor = [CPColor colorWithRed:115/255 green:115/255 blue:115/255 alpha:1];
        warningCharCountColor = [CPColor colorWithHexString:"952725"];

        //add a textfield for the number of chars left
        charsLeftField = [[CPTextField alloc] initWithFrame:CGRectMake(370, 5, 30, 17)];
        [charsLeftField setStringValue:"140"];
        [charsLeftField setTextColor:normalCharCountColor]
        [charsLeftField setFont:[CPFont systemFontOfSize:11]];
        [self._windowView._headView addSubview:charsLeftField];

        var contentView = [self contentView];

        if (aTweet)
        {
            var user =(aTweet.user) ? aTweet.user.name : aTweet.from_user;
            [self setTitle:"In reply to "+user];
        }

        var bottomView = [[CPView alloc] initWithFrame:CGRectMake(0, 100, 400, 35)];
        bg = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"bottomColor.png"]];
        [bottomView setBackgroundColor:[CPColor colorWithPatternImage:bg]];

        var button = [[CPButton alloc] initWithFrame:CGRectMake(295, 5, 95, 24)];
        [button setTitle:"Post"];
        [bottomView addSubview:button];

        var color = [button currentValueForThemeAttribute:"bezel-color"],
            downColor = [button valueForThemeAttribute:"bezel-color" inState:CPThemeStateHighlighted];

        var button = [CPButtonBar actionPopupButton];
        [button setFrame:CGRectMake(255, 5, 35, 24)];
        [button setValue:color forThemeAttribute:"bezel-color"];
        [button setValue:downColor forThemeAttribute:"bezel-color" inState:CPThemeStateHighlighted];

        var item = [[CPMenuItem alloc] initWithTitle:"Shorten URLs..." action:nil keyEquivalent:"s"];
        [item setKeyEquivalentModifierMask:CPAlternateKeyMask|CPCommandKeyMask];
        [button addItem:item];

        [button addItem:[CPMenuItem separatorItem]];
        [button addItemWithTitle:"Add Image..."];

        var item = [[CPMenuItem alloc] initWithTitle:"Record Video..." action:nil keyEquivalent:"v"];
        [item setKeyEquivalentModifierMask:CPAlternateKeyMask|CPCommandKeyMask];
        [button addItem:item];

        [bottomView addSubview:button];

        var button = [[CPPopUpButton alloc] initWithFrame:CGRectMake(5,5, 135, 24)];
        [button setImageOffset:5];

        var item = [[CPMenuItem alloc] initWithTitle:"Me1000" action:nil keyEquivalent:nil];
        [item setImage:[[CPImage alloc] initWithContentsOfFile:"http://a3.twimg.com/profile_images/940080497/IMG_2697_normal.jpg" size:CGSizeMake(15,15)]];
        [button addItem:item];

        var item = [[CPMenuItem alloc] initWithTitle:"Cappuccino" action:nil keyEquivalent:nil];
        [item setImage:[[CPImage alloc] initWithContentsOfFile:"http://a0.twimg.com/profile_images/59980309/cappuccino-icon_normal.png" size:CGSizeMake(15,15)]];
        [button addItem:item];

        [bottomView addSubview:button];


        var scroll = [[CPScrollView alloc] initWithFrame:CGRectMake(0, 0, 400, 100)];
        [scroll setAutohidesScrollers:YES];
        [scroll setHasHorizontalScroller:NO];

        text = [[EditTweetTextView alloc] initWithFrame:CGRectMake(0,0,400,100)];
        [text setDelegate:self];
        [self makeFirstResponder:text];

        [scroll setDocumentView:text];
        [contentView addSubview:scroll];

        if (aTweet)
        {
            [text setStringValue:"@" + user + " "];
            [text moveCursorToEnd];
        }


        [contentView addSubview:bottomView];
    }

    return self;
}

- (void)setCharCount:(CPNumber)chars
{
    [charsLeftField setStringValue:"" + chars];
    if(chars < 0)
        [charsLeftField setTextColor:warningCharCountColor];
    else
        [charsLeftField setTextColor:normalCharCountColor];
}

- (void)windowDidBecomeKey:(CPNotification)notification
{
    [text focus];
}

- (void)windowDidResignKey:(CPNotification)notification
{
    [text blur];
}

@end