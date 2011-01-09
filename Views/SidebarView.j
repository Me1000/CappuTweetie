@implementation SidebarView : CPView
{
    CPArray accounts;
    int     activeAccount;

    CPButton tweetsButton;
    CPButton replyButton;
    CPButton messagesButton;
    CPButton searchButton;

    CPView   buttonContainer;

    CPArray avatarViews;
}

- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    
    if(self)
    {
        activeAccount = 0;
        accounts = [];
        avatarViews = [];

        var sidebg = [CPColor colorWithPatternImage:[[CPThreePartImage alloc] initWithImageSlices:[
            [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/sidebar-top.png"] size:CGSizeMake(60,5)],
            [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/sidebar-middle.png"] size:CGSizeMake(60,4)],
            [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/sidebar-middle.png"] size:CGSizeMake(60,4)]
        ] isVertical:YES]];

        [self setBackgroundColor:sidebg];
    
        //var avatarView = [[CPImageView alloc] initWithFrame:CGRectMake(6,6,48,48)];
        //[avatarView setImage:];
        //[self addSubview:avatarView];

        buttonsContanier = [[CPView alloc] initWithFrame:CGRectMake(12,6,33,175)];

        tweetsButton   = [[CPButton alloc] initWithFrame:CGRectMake(0, 0, 32, 30)];
        replyButton    = [[CPButton alloc] initWithFrame:CGRectMake(0, 40, 33, 31)];
        messagesButton = [[CPButton alloc] initWithFrame:CGRectMake(0, 80, 29, 21)];
        searchButton   = [[CPButton alloc] initWithFrame:CGRectMake(0, 120, 25, 31)];

        var image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/SideTweets.png"] size:CGSizeMake(32, 30)];
        [tweetsButton setImage:image];
        [tweetsButton setBordered:NO];

        var image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/SideReplies.png"] size:CGSizeMake(32, 30)];
        [replyButton setImage:image];
        [replyButton setBordered:NO];

        var image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/SideMessages.png"] size:CGSizeMake(29, 21)];
        [messagesButton setImage:image];
        [messagesButton setBordered:NO];

        var image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/SideSearch.png"] size:CGSizeMake(25, 31)];
        [searchButton setImage:image];
        [searchButton setBordered:NO];

        [buttonsContanier setSubviews:[tweetsButton, replyButton, messagesButton, searchButton]];
        [self addSubview:buttonsContanier];

        [self addAccount:"Me1000"];
        [self addAccount:"Cappuccino"];
    }
    
    return self;
}

- (void)addAccount:(TwitterAccount)anAccount
{
    [accounts addObject:anAccount];

    // fix me: this image should be rounded by default
    var newAvatarView = [[CPButton alloc] initWithFrame:CGRectMake(4,0,48,48)];
    [newAvatarView setTarget:self];
    [newAvatarView setAction:@selector(setActiveAccount:)];
    [newAvatarView setBordered:NO];

    // FIX ME: use the real image dude...
    [newAvatarView setImage:[[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/avatar.png"] size:CGSizeMake(48,48)]];
    [avatarViews addObject:newAvatarView];

    [self setNeedsLayout];
}

- (void)setActiveAccount:(id)sender
{
    var idx = [avatarViews indexOfObject:sender];
    activeAccount = idx;

    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    var i = 0,
        c = accounts.length,
        y = 6,
        animations = [];

    for (; i < c; i++)
    {
        var avatar = avatarViews[i],
            newOrigin = CGPointMake(4, y);

        [self addSubview:avatar];

        var newAni = [CPDictionary dictionaryWithObjects:[avatar, [avatar frame], CGRectMake(4, y, 48, 48)]
                                                 forKeys:[CPViewAnimationTargetKey, CPViewAnimationStartFrameKey, CPViewAnimationEndFrameKey]];
        [animations addObject:newAni];
        y += 65;


        if (i === activeAccount)
        {
            var newAni = [CPDictionary dictionaryWithObjects:[buttonsContanier, [buttonsContanier frame], CGRectMake(12, y, 33, 175)]
                                                 forKeys:[CPViewAnimationTargetKey, CPViewAnimationStartFrameKey, CPViewAnimationEndFrameKey]];
            [animations addObject:newAni];
            y += 160;
        }
    }

    var animation = [[CPViewAnimation alloc] initWithViewAnimations:animations];

    [animation setDuration:.15];
    [animation setAnimationCurve:CPAnimationEaseInOut];
    [animation setDelegate:self];
    [animation startAnimation];
}

@end