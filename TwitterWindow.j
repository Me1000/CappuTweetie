@implementation TwitterWindow : _CPStandardWindowView
{

}
- (void)tile
{
    [super tile];

    var theWindow = [self window],
        bounds = [self bounds],
        width = CGRectGetWidth(bounds);

    [_headView setFrameSize:CGSizeMake(width, [self toolbarMaxY])];
    //[_dividerView setFrame:CGRectMake(0.0, CGRectGetMaxY([_headView frame]), width, 1.0)];

    //var dividerMaxY = CGRectGetMaxY([_dividerView frame]);
    var maxY = CGRectGetMaxY([_headView frame]);

    [_bodyView setFrame:CGRectMake(0.0, maxY, width, CGRectGetHeight(bounds) - maxY)];

    var leftOffset = 8;

    if (_closeButton)
        leftOffset += 19.0;
    if (_minimizeButton)
        leftOffset += 19.0;

    [_titleField setFrame:CGRectMake(leftOffset, 5.0, width - leftOffset*2.0, CGRectGetHeight([_titleField frame]))];

    [[theWindow contentView] setFrame:CGRectMake(0.0, maxY,width,CGRectGetHeight(bounds)+1)];
}
@end