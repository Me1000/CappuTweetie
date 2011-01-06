@import "RelativeDateFormatter.j"

@implementation TweetDataView : CPView
{
    CPTextField authorName;
    CPTextField timeSinceTweet;
    CPTextField tweetText;
    CPButton    replyButton;
    CPImageView authorAvatarView;

    JSObject    tweet;
}

- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];

    if (self)
    {
        authorName = [[CPTextField alloc] initWithFrame:CGRectMake(75, 5, 100, 20)];
        [authorName setFont:[CPFont boldSystemFontOfSize:13]];
        
        timeSinceTweet = [[CPTextField alloc] initWithFrame:CGRectMake(180, 5, aFrame.size.width - 210, 20)];
        [timeSinceTweet setFont:[CPFont systemFontOfSize:11]];
        [timeSinceTweet setTextColor:[CPColor grayColor]];
        [timeSinceTweet setAlignment:CPRightTextAlignment];
        
        tweetText = [[TweetTextView alloc] initWithFrame:CGRectMake(75, 25, aFrame.size.width - 100, 20)];

        
        replyButton = [[CPButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(aFrame) - 28, 5, 20, 20)];
        [replyButton setBordered:NO];
        [replyButton setTarget:self];
        [replyButton setAction:@selector(replyToTweet:)];
        var replyimage = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"SubtleReply.png"] size:CGSizeMake(18, 13)];
        var altImage = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"SubtleReplyActive.png"] size:CGSizeMake(18, 13)];

        [replyButton setImage:replyimage];
        [replyButton setAlternateImage:altImage];
        [replyButton setAutoresizingMask:CPViewMinXMargin];
        
        authorAvatarView = [[CPImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];

        var tweetBackground = [[CPView alloc] initWithFrame:CGRectMake(60, 2, aFrame.size.width - 62, aFrame.size.height - 4)];

        var tweetBubbleImages = [
                [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"TweetBubble/TweetBubble_01.png"] size:CGSizeMake(19, 16)],
                [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"TweetBubble/TweetBubble_02.png"] size:CGSizeMake(3,  16)],
                [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"TweetBubble/TweetBubble_03.png"] size:CGSizeMake(15, 16)],

                [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"TweetBubble/TweetBubble_04.png"] size:CGSizeMake(19, 2)],
                [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"TweetBubble/TweetBubble_05.png"] size:CGSizeMake(3,  2)],
                [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"TweetBubble/TweetBubble_06.png"] size:CGSizeMake(15, 2)],

                [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"TweetBubble/TweetBubble_07.png"] size:CGSizeMake(19, 14)],
                [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"TweetBubble/TweetBubble_08.png"] size:CGSizeMake(3,  14)],
                [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"TweetBubble/TweetBubble_09.png"] size:CGSizeMake(15, 14)]
            ],
            bg = [CPColor colorWithPatternImage:[[CPNinePartImage alloc] initWithImageSlices:tweetBubbleImages]];

        [tweetBackground setBackgroundColor:bg];
        [tweetBackground setAutoresizingMask:CPViewHeightSizable|CPViewWidthSizable];

        [self setSubviews:[tweetBackground, authorName, timeSinceTweet, tweetText, replyButton, authorAvatarView]];
    }

    return self;
}

- (void)replyToTweet:(id)sender
{
    // FIX ME: this will need to be a custom window since it has to display the char count in the top right corner
    var replyWindow = [[CPWindow alloc] initWithContentRect:CGRectMake(100, 100, 400, 135) styleMask:CPTitledWindowMask|CPClosableWindowMask|CPMiniaturizableWindowMask],
        contentView = [replyWindow contentView];

    [replyWindow setTitle:"In reply to "+tweet.user.name];


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

    var button = [[CPPopUpButton alloc] initWithFrame:CGRectMake(5,5, 115, 24)];

    var item = [[CPMenuItem alloc] initWithTitle:"Me1000" action:nil keyEquivalent:nil];
    [item setImage:[[CPImage alloc] initWithContentsOfFile:"http://a3.twimg.com/profile_images/940080497/IMG_2697_normal.jpg" size:CGSizeMake(15,15)]];
    [button addItem:item];

    var item = [[CPMenuItem alloc] initWithTitle:"Cappuccino" action:nil keyEquivalent:nil];
    [item setImage:[[CPImage alloc] initWithContentsOfFile:"http://a0.twimg.com/profile_images/59980309/cappuccino-icon_normal.png" size:CGSizeMake(15,15)]];
    [button addItem:item];

    [bottomView addSubview:button];
    [contentView addSubview:bottomView];

    [replyWindow orderFront:self];

    // FIX ME: we really need a CoreText solution for typing... similar to the tweet view. As we type we need to make hash tags gray, links highlighted, and usrnames blue.
}

- (void)setValue:(id)value forKey:(id)bindingPath
{
    [self setObjectValue:value];
}

- (void)setObjectValue:(id)aTweet
{
    if (!aTweet)
        return;

    tweet = aTweet;

    [authorName setStringValue:aTweet.user.name];

    var tweetDate = new Date(aTweet.created_at);
    [timeSinceTweet setStringValue:[tweetDate relativeDateSinceNow]];

    [tweetText setStringValue:aTweet.text];

    var frame = [tweetText frame],
        height = [self bounds].size.height - 35;

    frame.size.height = height;

    [tweetText setFrame:frame];

    var userImage = [[CPImage alloc] initWithContentsOfFile:aTweet.user.profile_image_url size:CGSizeMake(50,50)];
    [authorAvatarView setImage:userImage];
}

- (id)objectValue
{

}

/*- (void)drawRect:(CGRect)aRect
{
    var context = [[CPGraphicsContext currentContext] graphicsPort],
        rect2 = [self bounds],
        aRect = [self bounds],
        xMin = 67,
        xMax = aRect.size.width - 3,
        yMin = 2,
        yMax = aRect.size.height - 4,
        radius = 3,
        path = CGPathCreateMutable();

    if (rect2.size.height !== aRect.size.height)
    {
        alert();
        console.log(rect2, aRect);
    }

    CGPathMoveToPoint(path, nil, xMin, yMin);

    // top right
    CGPathAddLineToPoint(path, nil, xMax - radius, yMin);
    CGPathAddCurveToPoint(path, nil, xMax - radius, yMin, xMax, yMin, xMax, yMin + radius);

    // bottom right
    CGPathAddLineToPoint(path, nil, xMax, yMax - radius);
    CGPathAddCurveToPoint(path, nil, xMax, yMax - radius, xMax, yMax, xMax - radius, yMax);

    // bottom left
    CGPathAddLineToPoint(path, nil, xMin + radius, yMax);
    CGPathAddCurveToPoint(path, nil, xMin + radius, yMax, xMin, yMax, xMin, yMax - radius);

    CGContextSetLineJoin(context, kCGLineCapSquare);

    // now for the pointy thing
    CGPathAddLineToPoint(path, nil, xMin, yMin + 15);
    CGPathAddLineToPoint(path, nil, xMin - 8, yMin + 7);


    //CGPathAddCurveToPoint(path, nil, xMin, yMin + radius, xMin, yMin, xMin + radius, yMin);


    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);

    [[CPColor colorWithRed:242/255 green:242/255 blue:242/255 alpha:1] setFill];
    [[CPColor colorWithRed:184/255 green:184/255 blue:184/255 alpha:1] setStroke];

    var shadowColor = [CPColor colorWithRed:184/255 green:184/255 blue:184/255 alpha:.5];

    CGContextSetShadowWithColor(context, CGSizeMake(0,1), 0, shadowColor);

    CGContextStrokePath(context);
    CGContextFillPath(context);
}*/

- (void)encodeWithCoder:(CPCoder)aCoder
{
    [super encodeWithCoder:aCoder];

    [aCoder encodeObject:authorName forKey:"authorName"];
    [aCoder encodeObject:timeSinceTweet forKey:"timeSinceTweet"];
    [aCoder encodeObject:tweetText forKey:"tweetText"];
    [aCoder encodeObject:replyButton forKey:"replyButton"];
    [aCoder encodeObject:authorAvatarView forKey:"authorAvatarView"];
}

- (id)initWithCoder:(CPCoder)aCoder
{
    self = [super initWithCoder:aCoder];

    if (self)
    {
        authorName       = [aCoder decodeObjectForKey:"authorName"];
        timeSinceTweet   = [aCoder decodeObjectForKey:"timeSinceTweet"];
        tweetText        = [aCoder decodeObjectForKey:"tweetText"];
        replyButton      = [aCoder decodeObjectForKey:"replyButton"];
        authorAvatarView = [aCoder decodeObjectForKey:"authorAvatarView"];
    }

    return self;
}

@end

/*
    This class does some hacky dom stuff to display rich text for tweets
*/
@implementation TweetTextView : CPView
{
    TweetDataView dataview;
    DOMElement    textContainer;

    CPString      stringValue;
}

- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];

    if (self)
    {
        stringValue = "";

        textContainer = document.createElement("div");
        textContainer.style.position = "absolute";
        textContainer.style.font = "normal normal normal 13px/normal Arial, sans-serif";

        _DOMElement.appendChild(textContainer);
    }

    return self;
}

- (void)mouseDown:(CPEvent)anEvent
{
    if (anEvent.target.tagName !== "A")
        [super mouseDown:anEvent];
}

- (void)mouseUp:(CPEvent)anEvent
{
    var all = textContainer.getElementsByTagName('*'),
        count = all.length;

    while(count--)
        all[count].style.background = "transparent";

    [super mouseUp:anEvent];
}

- (void)setStringValue:(CPString)aValue
{
    stringValue = aValue;

    //replace hashes
    var aValue =  aValue.replace(new RegExp("#([\\w_]+)", "g") ,"<a href='#' style='color:#666; text-decoration:none;' onmousedown='this.style.background = \"#bed2e7\";'>#$1</a>"); 

    // replace the usernames with links
    html = aValue.replace(new RegExp("@([\\w_]+)", "g"), "<a href=\"#\" style=\"color:#2c93d5; text-decoration:none;\" onmousedown='this.style.background = \"#bed2e7\";'>@$1</a>");

    var linkReplace = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
    html =  html.replace(linkReplace, "<a href='#' onclick=\"OPEN_LINK('$1')\" style='color:#2c93d5; text-decoration:none;' onmousedown='this.style.background = \"#bed2e7\";'>$1</a>"); 

    
    textContainer.innerHTML = html;
}

- (CPString)stringValue
{
    return stringValue;
}

- (id)initWithCoder:(CPCoder)aCoder
{
    self = [super initWithCoder:aCoder];

    if (self)
    {
        textContainer = document.createElement("span");
        textContainer.style.position = "absolute";
        textContainer.style.font = "normal normal normal 13px/normal Arial, sans-serif";

        _DOMElement.appendChild(textContainer);
    }

    return self;
}

@end