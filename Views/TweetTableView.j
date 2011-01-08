@implementation TweetTableView : CPTableView

- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    
    if(self)
    {
		[self setHeaderView:nil];
	    [self setCornerView:nil];
	}
	
	return self;
}

- (void)highlightSelectionInClipRect:(CGRect)aRect
{
	var selectedRow = [self selectedRow];
	if(selectedRow == -1) return;
	
	var context = [[CPGraphicsContext currentContext] graphicsPort];
	var rgb = CGColorSpaceCreateDeviceRGB();
	var startColor = CGColorCreate(rgb, [241/255, 241/255, 241/255, 1]);
	var endColor = CGColorCreate(rgb, [241/255, 241/255, 241/255, 0]);
	var gradient = CGGradientCreateWithColors(rgb, [startColor, endColor], [0, 1]);
	
	var drawingRect = [self rectOfRow:selectedRow];
	var midY = CGRectGetMidY(drawingRect);
	var startPoint = CGPointMake(CGRectGetMinX(drawingRect), midY);
	var endPoint = CGPointMake(CGRectGetMaxX(drawingRect), midY);
	
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	CGContextFillRect(context, drawingRect);
}

@end