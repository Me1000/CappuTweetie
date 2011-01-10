@implementation SidebarView : CPView
{
    CPArray     accounts;
    int         activeAccount;
    
    CPView      buttonContainer;
    CPButton    tweetsButton;
    CPButton    replyButton;
    CPButton    messagesButton;
    CPButton    searchButton;
    CPImageView selectionArrow;
    CPButton    activeButton;

    CPArray     avatarViews;
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
    
        buttonsContanier = [[CPView alloc] initWithFrame:CGRectMake(12,6,48,175)];

        tweetsButton   = [[SidebarButton alloc] initWithFrame:CGRectMake(0, 0, 32, 31)];
        replyButton    = [[SidebarButton alloc] initWithFrame:CGRectMake(0, 42, 33, 31)];
        messagesButton = [[SidebarButton alloc] initWithFrame:CGRectMake(0, 82, 29, 30)];
        searchButton   = [[SidebarButton alloc] initWithFrame:CGRectMake(0, 120, 25, 31)];

        var image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/SideTweets.png"] size:CGSizeMake(32, 30)];
        [tweetsButton setImage:image];
        [tweetsButton setTarget:self];
        [tweetsButton setAction:@selector(setActiveButton:)];
        [tweetsButton setSelected:YES];
        [self setActiveButton:tweetsButton];

        var image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/SideReplies.png"] size:CGSizeMake(32, 30)];
        [replyButton setImage:image];
        [replyButton setTarget:self];
        [replyButton setAction:@selector(setActiveButton:)];

        var image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/SideMessages.png"] size:CGSizeMake(29, 21)];
        [messagesButton setImage:image];
        [messagesButton setTarget:self];
        [messagesButton setAction:@selector(setActiveButton:)];

        var image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/SideSearch.png"] size:CGSizeMake(25, 31)];
        [searchButton setImage:image];
        [searchButton setTarget:self];
        [searchButton setAction:@selector(setActiveButton:)];
        
        selectionArrow = [[CPImageView alloc] initWithFrame:CPRectMake(34, 0, 14, 28)];
        var image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/SelectionNipple.png"] size:CGSizeMake(14, 28)];
        [selectionArrow setImage:image];

        [buttonsContanier setSubviews:[tweetsButton, replyButton, messagesButton, searchButton, selectionArrow]];
        [self addSubview:buttonsContanier];

        [self addAccount:"Me1000"];
        [self addAccount:"Cappuccino"];
    }
    
    return self;
}

- (void)addAccount:(TwitterAccount)anAccount
{
    [accounts addObject:anAccount];
    // TODO: this should use the AccountController to store its data instead...

    // fix me: this image should be rounded by default
    var newAvatarView = [[SidebarButton alloc] initWithFrame:CGRectMake(4,0,48,48)];
    [newAvatarView setTarget:self];
    [newAvatarView setAction:@selector(setActiveAccount:)];
    
    if(accounts.length == 1)
        [newAvatarView setSelected:YES];

    // FIX ME: use the real image dude...
    [newAvatarView setImage:[[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/avatar.png"] size:CGSizeMake(48,48)]];
    [avatarViews addObject:newAvatarView];

    [self setNeedsLayout];
}

- (void)setActiveAccount:(id)sender
{
    [[avatarViews objectAtIndex:activeAccount] setSelected:NO];
    [sender setSelected:YES];
    
    var idx = [avatarViews indexOfObject:sender];
    activeAccount = idx;

    [self setNeedsLayout];
}

- (void)setActiveButton:(id)sender
{
    [activeButton setSelected:NO];
    [sender setSelected:YES];
    
    activeButton = sender;
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
            var newAni = [CPDictionary dictionaryWithObjects:[buttonsContanier, [buttonsContanier frame], CGRectMake(12, y, 48, 175)]
                                                 forKeys:[CPViewAnimationTargetKey, CPViewAnimationStartFrameKey, CPViewAnimationEndFrameKey]];
            [animations addObject:newAni];
            y += 160;
        }
    }
    
    // move the selection arrow
    var buttonFrame = [activeButton frame],
        newAni = [CPDictionary dictionaryWithObjects:[selectionArrow, [selectionArrow frame], CPRectMake(34, CGRectGetMinY(buttonFrame), 14, 28)]
                                             forKeys:[CPViewAnimationTargetKey, CPViewAnimationStartFrameKey, CPViewAnimationEndFrameKey]];
                                             
    [animations addObject:newAni];

    var animation = [[CPViewAnimation alloc] initWithViewAnimations:animations];

    [animation setDuration:0.2];
    [animation setAnimationCurve:CPAnimationEaseInOut];
    [animation setDelegate:self];
    [animation startAnimation];
}

@end

@implementation SidebarButton : CPButton
{
    BOOL selected @accessors;
    CPAnimation currentAnimation;
}

- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    
    if(self)
    {
        [self setBordered:NO];
        [self setSelected:NO];
    }
    
    return self;
}

- (void)setSelected:(BOOL)isSelected
{
    selected = isSelected;
    [self setAlphaValue:(selected ? 1 : 0.5)]
}

- (void)highlight:(CPInteger)isHighlighted
{
    if(selected) return;
    [super highlight:isHighlighted];
    [currentAnimation stopAnimation];
    
    if(isHighlighted)
        currentAnimation = [DimAnimation animateView:self toAlphaValue:1];
        
    else
        currentAnimation = [DimAnimation animateView:self toAlphaValue:0.5];
}

- (void)stopTracking:(CGPoint)lastPoint at:(CGPoint)aPoint mouseIsUp:(BOOL)mouseIsUp
{
    if(!mouseIsUp)
        [self highlight:NO];
}

- (void)sendAction:(SEL)anAction to:(id)anObject
{
    [super sendAction:anAction to:anObject];
    [self highlight:NO]; // moved from stopTracking so that selected can be modified before highlight is called
}

@end

@implementation DimAnimation : CPAnimation
{
    CPView view;
    int startValue;
    int endValue;
}

+ (void)animateView:(CPView)aView toAlphaValue:(int)anAlphaValue
{
    var animation = [[DimAnimation alloc] initWithView:aView endAlphaValue:anAlphaValue];
    [animation startAnimation];
    return animation;
}

- (void)initWithView:(CPView)aView endAlphaValue:(int)anEndValue
{
    view = aView;
    endValue = anEndValue;
    
    [self setDuration:0.15];
    [self setAnimationCurve:CPAnimationEaseInOut];
    return self;
}

- (void)startAnimation
{
    startValue = [view alphaValue];
    [super startAnimation];
}

- (void)setCurrentProgress:(CPAnimationProgress)progress
{
    [super setCurrentProgress:progress];
    [view setAlphaValue:startValue + (endValue - startValue) * progress];
}

@end