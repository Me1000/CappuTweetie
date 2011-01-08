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

    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    var rows = [self numberOfRows],
        rect = [self rectOfRow:rows - 1],
        origin = rect.origin;

    origin.x = rect.size.width / 2;
    origin.y = origin.y + rect.size.height;

    // resize to make room
    [self setFrameSize:CGSizeMake(rect.size.width, rect.origin.y + 70)];

    if (isLoading) // && numberOfRows > 0
    {
        //show the spinny
        [dot removeFromSuperview];
        [spinny setFrameOrigin:CGPointMake(origin.x - 32, origin.y)];
        [self addSubview:spinny];
    }
    else
    {
        // show a dot
        [spinny removeFromSuperview];
        [dot setFrameOrigin:CGPointMake(origin.x - 2, origin.y + 30)];
        [self addSubview:dot];
    }
}

- (void)highlightSelectionInClipRect:(CGRect)aRect
{
	var selectedRow = [self selectedRow];
	if(selectedRow == -1) return;
	
	var context = [[CPGraphicsContext currentContext] graphicsPort],
	    rgb = CGColorSpaceCreateDeviceRGB();
	    startColor = CGColorCreate(rgb, [241/255, 241/255, 241/255, 1]);
	    endColor = CGColorCreate(rgb, [241/255, 241/255, 241/255, 0]);
	    gradient = CGGradientCreateWithColors(rgb, [startColor, endColor], [0, 1]);
	
	var drawingRect = [self rectOfRow:selectedRow],
	    midY = CGRectGetMidY(drawingRect);
	    startPoint = CGPointMake(CGRectGetMinX(drawingRect), midY);
	    endPoint = CGPointMake(CGRectGetMaxX(drawingRect), midY);
	
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	CGContextFillRect(context, drawingRect);
}

@end