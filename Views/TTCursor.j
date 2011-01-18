/*
 * TTCursor.j
 * Created by Devon Govett
 *
 * This class represents the blinking cursor for a EditTweetTextView.
 */

TTCursorSelectionStart = 1;
TTCursorSelectionEnd = 2;

@implementation TTCursor : CPObject
{
    int                 line        @accessors;
    int                 column      @accessors;    
    EditTweetTextView   textView              ;
    BOOL                showing     @accessors;
    JSObject            timer;
}

/*
 * Initialize a new cursor with a text view.
 */
- (void)initWithTextView:(EditTweetTextView)aTextView
{
    self = [super init];
    
    if(self)
    {
        textView = aTextView;
        line = 0;
        column = 0;
        showing = YES;
    }
    
    return self;
}

/*
 * Move the cursor up one line.
 * Pass a boolean representing whether the textView should repaint right away or not
 */
- (void)moveUp:(BOOL)paint
{
    // FIXME: this should be the character *visually* above, not nescessarily the same column number...
    line = MAX(0, line - 1);
    column = MIN([[textView lines] objectAtIndex:line].length, column);
    
    if(paint)
        [self show];
}

/*
 * Move the cursor down one line.
 * Pass a boolean representing whether the textView should repaint right away or not
 */
- (void)moveDown:(BOOL)paint
{
    // FIXME: this should be the character *visually* below, not nescessarily the same column number...
    var lines = [textView lines];
    line = MIN(lines.length - 1, line + 1);
    column = MIN(lines[line].length, column);
    
    if(paint)
        [self show];
}

/*
 * Move the cursor left one column.
 * Pass a boolean representing whether the textView should repaint right away or not
 */
- (void)moveLeft:(BOOL)paint
{
    if(line > 0 && column === 0)
    {
        line--;
        column = [[textView lines] objectAtIndex:line].length;
    }
    else
    {
        column = MAX(0, column - 1);
    }
    
    if(paint)
        [self show];
}

/*
 * Move the cursor right one column.
 * Pass a boolean representing whether the textView should repaint right away or not
 */
- (void)moveRight:(BOOL)paint
{
    var lines = [textView lines];
    if(line < lines.length - 1 && column === lines[line].length)
    {
        line++;
        column = 0;
    }
    else
    {
        column = MIN(lines[line].length, column + 1);
    }
    
    if(paint)
        [self show];
}

/*
 * Move the cursor to the end of the text in the textView.
 * Pass a boolean representing whether the textView should repaint right away or not
 */
- (void)moveToEnd:(BOOL)paint
{
    var lines = [textView lines];
    line = lines.length - 1;
    column = lines[line].length;
    
    if(paint)
        [self show];
}

/*
 * Take the cursor position from one end of a text selection object.
 * Pass a selection and either TTCursorSelectionStart or TTCursorSelectionEnd 
 * to represent which end you want to take the cursor position from.
 */
- (void)takeFromSelection:(TTSelection)selection position:(TTCursorPosition)position
{
    if(!selection || !position)
        return;
    
    switch(position)
    {
        case TTCursorSelectionStart:
            line = [selection startLine];
            column = [selection startColumn];
            break;
            
        case TTCursorSelectionEnd:
            line = [selection endLine];
            column = [selection endColumn];
    }
    
    return null;
}

/*
 * Toggle the cursor's visibility and redraw the textView
 */
- (void)toggleDisplay
{
    showing = !showing;
    [textView setNeedsDisplay:YES];
}

/*
 * Show the cursor and redraw the textView
 */
- (void)show
{
    showing = YES;
    [textView setNeedsDisplay:YES];
}

/*
 * Hide the cursor
 */
- (void)hide
{
    [self stopBlinking];
    showing = NO;
    [textView setNeedsDisplay:YES];
}

/*
 * Start the cursor blinking
 */
- (void)blink
{
    [self stopBlinking];
    [self show];
    timer = setInterval(function() {
        [self toggleDisplay];
    }, 500);
}

/*
 * Stop the cursor from blinking
 */
- (void)stopBlinking
{
    clearInterval(timer);
    [self show];
}

@end