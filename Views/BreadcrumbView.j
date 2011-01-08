@implementation BreadcrumbView : CPView
{
    CPArray items;
    CPView  container;
}

- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    
    if(self)
    {
        items = [[CPArray alloc] init];
        container = [[CPView alloc] initWithFrame:CGRectMake(0, 0, aFrame.size.width, aFrame.size.height)];

        [self addSubview:container];

        var windowBG = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"windowToolbar3.png"] size:CGSizeMake(25,27)]
        [self setBackgroundColor:[CPColor colorWithPatternImage:windowBG]];
    }
    
    return self;
}

- (void)addItem:(CPString)aTitle
{
    var item = [[BreadcrumbItem alloc] initWithFrame:CGRectMake(0, 0, 0, 26) title:aTitle owner:self];
    [items addObject:item];

    [self setNeedsLayout];
}

- (void)setFirstItem:(CPString)aTitle
{
    [items removeAllObjects];

    var item = [[BreadcrumbItem alloc] initWithFrame:CGRectMake(0, 0, 0, 26) title:aTitle owner:self];
    [items addObject:item];
}

- (void)jumpToItem:(BreadcrumbItem)anItem
{
    var index = [items indexOfObject:anItem];   
    [items removeObjectsInRange:CPMakeRange(index + 1, [items count])];
    [self setNeedsLayout];
    
    // Notify someone here that the view changed...
    console.log('Jump to ' + index);
}

- (void)layoutSubviews
{
    // we're actually going to lay this out in reverse order... since the oldest items get cut off


    var i = 0,
        c = items.length,
        x = 10;

    for (; i < c; i++)
    {
        var item = items[i];

        [item setFrameOrigin:CGPointMake(x, 0)];
        x += CGRectGetWidth([item frame]) + 10;
        [container addSubview:item];
    }

    [container setFrameSize:CGSizeMake(x, [container bounds].size.height)];

    var width = [self bounds].size.width;

    if (x > width - 40)
    {
        var newX = width - x - 80;
        [container setFrameOrigin:CGPointMake(newX, 0)];
    }
    else
        [container setFrameOrigin:CGPointMakeZero()];
}

@end

@implementation BreadcrumbItem : CPButton

- (id)initWithFrame:(CGRect)aFrame title:(CPString)aTitle owner:(BreadcrumbView)anOwner
{
    self = [super initWithFrame:aFrame];
    
    if(self)
    {
        [self setBordered:NO];

        [self setTitle:aTitle];
        [self setTarget:anOwner];
        [self setAction:@selector(jumpToItem:)];

        [self setValue:[CPColor colorWithRed:60/255 green:60/255 blue:60/255 alpha:1] forThemeAttribute:"text-color"];
        [self setValue:[CPColor blackColor] forThemeAttribute:"text-color" inState:CPThemeStateHighlighted];
        [self setFont:[CPFont boldSystemFontOfSize:12]];
        [self setTextShadowColor:[CPColor colorWithWhite:1 alpha:.5]];
        [self setTextShadowOffset:CGSizeMake(0,1)];
        [self setAlignment:CPLeftTextAlignment]

        [self setImage:[[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"BreadcrumbDivider.png"] size:CGSizeMake(11,26)]];
        [self setImagePosition:CPImageRight];
        [self setImageOffset:10];

        [self sizeToFit];
    }
    
    return self;
}

@end