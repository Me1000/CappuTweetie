@implementation TweetScroller : CPScroller

- (id)initWithFrame:(CGRect)aFrame
{
	self = [super initWithFrame:aFrame];
	
	if(self)
	{
		var scrollerColor = [CPColor colorWithPatternImage:[[CPThreePartImage alloc] initWithImageSlices:[
            [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"scroller/scroller_0.png"] size:CGSizeMake(11, 5)],
            [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"scroller/scroller_1.png"] size:CGSizeMake(11, 2)],
            [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"scroller/scroller_2.png"] size:CGSizeMake(11, 5)]
        ] isVertical:YES]];

		var bgColor = [CPColor colorWithRed:210/255 green:210/255 blue:210/255 alpha:1];
		
		[self setValue:scrollerColor forThemeAttribute:"knob-color"];
	    [self setValue:bgColor forThemeAttribute:"knob-slot-color"];
	    [self setValue:bgColor forThemeAttribute:"increment-line-color"];
	    [self setValue:bgColor forThemeAttribute:"decrement-line-color"];
	    [self setValue:CGSizeMake(11,15) forThemeAttribute:"decrement-line-size"];
	    [self setValue:CGSizeMake(11,15) forThemeAttribute:"increment-line-size"];
	}
	
	return self;
}

@end