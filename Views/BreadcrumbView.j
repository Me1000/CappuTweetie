@implementation BreadcrumbView : CPView
{
	CPArray items;
	int maxX;
}

- (id)initWithFrame:(CGRect)aFrame
{
	self = [super initWithFrame:aFrame];
	
	if(self)
	{
		maxX = 60;
		items = [[CPArray alloc] init];
		
		var windowBG = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"windowToolbar3.png"] size:CGSizeMake(25,27)]
		[self setBackgroundColor:[CPColor colorWithPatternImage:windowBG]];
	}
	
	return self;
}

- (void)addItem:(CPString)aTitle
{
	var item = [[BreadcrumbItem alloc] initWithFrame:CGRectMake(maxX + 8, 0, 0, 26) title:aTitle owner:self];
	maxX = CGRectGetMaxX([item frame]);
	[self addSubview:item];
	[items addObject:item];
}

- (void)jumpToItem:(BreadcrumbItem)anItem
{
	var index = [items indexOfObject:anItem];	
	[items removeObjectsInRange:CPMakeRange(index + 1, [items count])];
	[self setSubviews:items];
	
	// Notify someone here that the view changed...
	console.log('Jump to ' + index);
}

@end

@implementation BreadcrumbItem : CPView
{
	CPString title @accessors;
	CPTextField label;
	CPColor labelColor;
	BreadcrumbView owner;
}

- (id)initWithFrame:(CGRect)aFrame title:(CPString)aTitle owner:(BreadcrumbView)anOwner
{
	self = [super initWithFrame:aFrame];
	
	if(self)
	{
		title = aTitle;
		owner = anOwner;
		labelColor = [CPColor colorWithRed:60/255 green:60/255 blue:60/255 alpha:1];
		
		label = [[CPTextField alloc] initWithFrame:CGRectMake(0,5,100,20)];
	    [label setStringValue:title];
	    [label setFont:[CPFont boldSystemFontOfSize:12]];
	    [label setTextColor:labelColor];
	    [label setTextShadowColor:[CPColor colorWithWhite:1 alpha:.5]];
	    [label setTextShadowOffset:CGSizeMake(0,1)];
		[label sizeToFit];
		
		[self addSubview:label];
		
		var divider = [[CPImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX([label frame]) + 5, 0, 11, 26)];
	    [divider setImage:[[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"BreadcrumbDivider.png"] size:CGSizeMake(11,26)]];
	    [self addSubview:divider];
	
		frame = [self frame];
		frame.size.width = CGRectGetMaxX([divider frame]);
		[self setFrame:frame];
	}
	
	return self;
}

- (void)mouseDown:(CPEvent)anEvent
{
	[label setTextColor:[CPColor blackColor]];
}

- (void)mouseUp:(CPEvent)anEvent
{	
	[label setTextColor:labelColor];
	
	var point = [self convertPoint:[anEvent locationInWindow] fromView:nil];
	if(CGRectContainsPoint([self bounds], point))
		[owner jumpToItem:self];
}

- (void)setTitle:(CPString)aTitle
{
	title = aTitle;
	[label setStringValue:aTitle];
}

@end