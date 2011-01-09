@import "../RelativeDateFormatter.j"

@implementation TweetDataView : CPView
{
    CPTextField authorName;
    CPTextField timeSinceTweet;
    CPTextField tweetText;
    CPButton    replyButton;
    CPView      authorAvatarView;

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
        
        authorAvatarView = [[RoundedImageView alloc] initWithFrame:CGRectMake(5, 5, 55, 55)];

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
    var replyWindow = [[NewTweetWindow alloc] initWithTweetReply:tweet];
    [replyWindow orderFront:self];

    // FIX ME: we really need a CoreText solution for typing... similar to the tweet view. As we type we need to make hash tags gray, links highlighted, and usernames blue.
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

    var style = [
        'text-decoration: none',
        'padding: 2px'
    ];
    
    var prefixes = ' -webkit- -moz-'.split(' ');
    for(var i = 0, len = prefixes.length; i < len; i++) {
        style.push(prefixes[i] + 'border-radius: 4px')
    }
    
    style = style.join(';');

    //replace hashes
    var aValue =  aValue.replace(new RegExp("#([\\w_]+)", "g") ,"<a href='#' style='color:#666;" + style + "' onmousedown='this.style.background = \"#bed2e7\";'>#$1</a>"); 

    // replace the usernames with links
    html = aValue.replace(new RegExp("@([\\w_]+)", "g"), "<a href=\"#\" style=\"color:#2c93d5;" + style + "\" onmousedown='this.style.background = \"#bed2e7\";'>@$1</a>");

    var linkReplace = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
    html =  html.replace(linkReplace, "<a href='#' onclick=\"OPEN_LINK('$1')\" style='color:#2c93d5;" + style + "' onmousedown='this.style.background = \"#bed2e7\";'>$1</a>"); 

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

@implementation RoundedImageView : CPView
{
    CPImage image @accessors;
    BOOL loaded;
    JSObject roundedImage;
}

- (void)setImage:(CPImage)anImage
{
    image = anImage;
    
    var size = [image size];
    [image setDelegate:self];

    if (size.width !== CPNotFound && size.height !== CPNotFound)
        [self setNeedsDisplay:YES];
}

- (void)imageDidLoad:(CPNotification)aNotification
{
    [self setNeedsDisplay:YES];
}

- (void)drawRoundedImage
{
    var rect = CGRectMake(0, 0, 50, 50),
        path = CGPathWithRoundedRectangleInRect(rect, 5, 5, YES, YES, YES, YES),
        context = CGBitmapGraphicsContextCreate();
        
    context.DOMElement.width = context.DOMElement.height = 50;
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawImage(context, rect, image);
    
    // hack attack for CGContextDrawImage!
    roundedImage = { _image: context.DOMElement };
}

- (void)imageDidLoad:(id)sender
{
    loaded = YES;
    [self drawRoundedImage];
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(CPRect)aRect
{
    if(!image || [image loadStatus] !== CPImageLoadStatusCompleted) return;
    
    var context = [[CPGraphicsContext currentContext] graphicsPort],
        shadowColor = [CPColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 2, shadowColor);
    CGContextDrawImage(context, CGRectMake(2, 0, 50, 50), roundedImage);
}

- (void)mouseEntered:(CPEvent)anEvent
{
    [[CPCursor pointingHandCursor] set];
}

- (void)mouseExited:(CPEvent)anEvent
{
    [[CPCursor arrowCursor] set];
}

@end