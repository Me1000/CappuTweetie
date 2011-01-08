@implementation SidebarView : CPView

- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    
    if(self)
    {
        var sidebg = [CPColor colorWithPatternImage:[[CPThreePartImage alloc] initWithImageSlices:[
            [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/sidebar-top.png"] size:CGSizeMake(60,5)],
            [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/sidebar-middle.png"] size:CGSizeMake(60,4)],
            [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/sidebar-middle.png"] size:CGSizeMake(60,4)]
        ] isVertical:YES]];

        [self setBackgroundColor:sidebg];
    
        var avatarView = [[CPImageView alloc] initWithFrame:CGRectMake(6,6,48,48)];
        [avatarView setImage:[[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Sidebar/avatar.png"] size:CGSizeMake(48,48)]];
        [self addSubview:avatarView];
    }
    
    return self;
}

@end