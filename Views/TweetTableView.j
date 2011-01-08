@implementation TweetTableView : CPTableView
{
    BOOL isLoading @accessors;
    CPProgressIndicator spinny;
    CPView         dot;
}

- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    
    if(self)
    {
        spinny = [[CPProgressIndicator alloc] initWithFrame:CGRectMake(0, 0 , 64, 64)];
        [spinny setStyle:CPProgressIndicatorSpinningStyle];
        dot = [[CPImageView alloc] initWithFrame:CGRectMake(0,0,5,6)];
    
        var image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"dot.png"] size:CGSizeMake(5,6)];
        [dot setImage:image];

        isLoading = YES;

	    [self setHeaderView:nil];
	    [self setCornerView:nil];
	}
	
	return self;
}

- (void)setIsLoading:(BOOL)aFlag
{
    isLoading = aFlag;

    if (isLoading)
    {
        [dot removeFromSuperview];
        [self addSubview:spinny];
    }
    else
    {
        [spinny removeFromSuperview];
        [self addSubview:dot];
    }
}

- (void)tile
{
    [super tile];

    var rect = [self rectOfRow:[self numberOfRows] - 1],
        origin = rect.origin;

    origin.x = rect.size.width / 2;

    if (!origin.y) // rows === 0
        origin = CGPointMake([self bounds].size.width/2, 10);
    else // resize to make room
        [self setFrameSize:CGSizeMake(rect.size.width, rect.size.height + origin.y + 70)];

    // set the position of our indicators
    [spinny setFrameOrigin:CGPointMake(origin.x - 32, rect.size.height + origin.y)];
    [dot setFrameOrigin:CGPointMake(origin.x - 2, rect.size.height + origin.y + 30)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    var position = CGRectGetMaxY([self visibleRect]);

    if (position > [self bounds].size.height - 100)
        [[self delegate] loadMoreTweets];
}

- (void)highlightSelectionInClipRect:(CGRect)aRect
{
	var selectedRow = [self selectedRow];
	if(selectedRow == -1) return;
	
	var context = [[CPGraphicsContext currentContext] graphicsPort],
	    rgb = CGColorSpaceCreateDeviceRGB(),
	    startColor = CGColorCreate(rgb, [241/255, 241/255, 241/255, 1]),
	    endColor = CGColorCreate(rgb, [241/255, 241/255, 241/255, 0]),
	    gradient = CGGradientCreateWithColors(rgb, [startColor, endColor], [0, 1]);
	
	var drawingRect = [self rectOfRow:selectedRow],
	    midY = CGRectGetMidY(drawingRect),
	    startPoint = CGPointMake(CGRectGetMinX(drawingRect), midY),
	    endPoint = CGPointMake(CGRectGetMaxX(drawingRect), midY);
	
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	CGContextFillRect(context, drawingRect);
}

@end