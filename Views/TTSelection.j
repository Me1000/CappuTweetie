/*
 * TTSelection.j
 * Created by Devon Govett
 *
 * This class represents a text selection for the EditTweetTextView class.
 */
 

@implementation TTSelection : CPObject
{
    int startLine    @accessors;
    int startColumn  @accessors;
    
    int endLine      @accessors;
    int endColumn    @accessors;
    
    int anchorLine   @accessors;
    int anchorColumn @accessors;
    
    int changingSide;
    int changingRow;
}

/*
 * Initialize a new selection with the passed anchor line and column
*/
- (void)initWithAnchorLine:(int)aLine column:(int)aColumn
{
    self = [super init];
    
    if(self)
    {
        startLine = aLine;
        startColumn = aColumn;
        
        endLine = aLine;
        endColumn = aColumn;
        
        anchorLine = aLine;
        anchorColumn = aColumn;
        
        changingSide = null; // 1 == left, 2 == right
        changingRow = null; // 1 == top, 2 == bottom
    }
    
    return self;
}

/*
 * Convienience method to initialize a new selection with the anchor being the current position of the passed cursor
*/
- (void)initWithAnchor:(TTCursor)anchor
{
    return [self initWithAnchorLine:[anchor line] column:[anchor column]];
}

/*
 * Extends the selection to the given line and column
*/
- (BOOL)extendToLine:(int)aLine column:(int)aColumn
{
    return [self extendToLine:aLine column:aColumn anchorCursor:NO];
}

/*
 * Extends the selection to the given cursor position
*/
- (BOOL)extendToCursorPosition:(JSObject)position
{
    return [self extendToLine:position.line column:position.column anchorCursor:YES];
}

/*
 * Extends the selection to the given line and column.
 * Passing YES to anchorCursor means that the selection will appear anchored to the original cursor position.
 * Passing NO to anchorCurso means that the selection will simply be extended in the direction given.
*/
- (BOOL)extendToLine:(int)aLine column:(int)aColumn anchorCursor:(BOOL)shouldAnchor
{
    var after = aLine > anchorLine || (aLine === anchorLine && aColumn > anchorColumn);
    
    if(after)
    {
        if(shouldAnchor)
        {
            startLine = anchorLine;
            startColumn = anchorColumn;
        }
        
        endLine = aLine;
        endColumn = aColumn;
    }
    else
    {
        startLine = aLine;
        startColumn = aColumn;
        
        if(shouldAnchor)
        {
            endLine = anchorLine;
            endColumn = anchorColumn;
        }
    }
    
    if(aLine === anchorLine && aColumn === anchorColumn)
    {
        startLine = startColumn = endLine = endColumn = null;
        return true;
    }
    
    return false;
}

/*
 * Returns whether the selection is of zero length (e.g. so that a cursor may be displayed)
*/
- (BOOL)hasNoLength
{
    return startLine === endLine && startColumn === endColumn;
}

/*
 * Extend the selection to the left by the given number of columns.
 * Also takes the array of lines from the text view
*/
- (void)extendLeft:(int)columns lines:(CPArray)lines
{
    if(!changingSide)
        changingSide = 1;
    
    if(changingSide === 1)
    {
        if(startLine > 0 && startColumn === 0)
        {
            startLine--;
            startColumn = lines[startLine].length - columns + 1;
        }
        else
            startColumn = MAX(0, startColumn - columns);
    }    
    else
    {
        if(endLine > 0 && endColumn === 0)
        {
            endLine--;
            endColumn = lines[endLine].length - columns + 1;
        }
        else
            endColumn -= columns;
    }
}

/*
 * Extend the selection to the right by the given number of columns.
 * Also takes the array of lines from the text view
*/
- (void)extendRight:(int)columns lines:(CPArray)lines
{
    if(!changingSide)
        changingSide = 2;
    
    if(changingSide === 2)
    {
        if(endLine < lines.length - 1 && endColumn === lines[endLine].length)
        {
            endLine++;
            endColumn = 0 + columns - 1;
        }
        else
            endColumn = MIN(lines[endLine].length, endColumn + columns);
    }    
    else
    {
        if(startLine < lines.length - 1 && startColumn === lines[endLine].length)
        {
            startLine++;
            startColumn = 0 + columns - 1;
        }
        else
            startColumn += columns;
    }
}

/*
 * Extend the selection up a line.
 * Takes the array of lines from the text view
*/
// FIXME: this should be the character *visually* above, not nescessarily the same column number...
- (void)extendUp:(CPArray)lines
{
    if(!changingRow || startLine < anchorLine)
        changingRow = 1;
        
    if(changingRow === 1)
    {
        startLine = MAX(0, startLine - 1);
        var len = lines[startLine].length;
        
        if(startColumn > len)
            startColumn = len;
            
        else if(startLine === anchorLine)
            startColumn = endColumn = anchorColumn;
    }
    else
    {
        endLine--;
        var len = lines[endLine].length;
        
        if(endColumn > len)
            endColumn = len;
            
        else if(startLine === anchorLine)
            startColumn = endColumn = anchorColumn;
    }
}

/*
 * Extend the selection down a line.
 * Takes the array of lines from the text view
*/
// FIXME: this should be the character *visually* below, not nescessarily the same column number...
- (void)extendDown:(CPArray)lines
{
    if(!changingRow || endLine > anchorLine)
        changingRow = 2;
        
    if(changingRow === 2)
    {
        endLine = MIN(lines.length - 1, endLine + 1);
        var len = lines[endLine].length;
        
        if(endColumn > len)
            endColumn = len;
            
        else if(startLine === anchorLine)
            startColumn = endColumn = anchorColumn;
    }
    else
    {
        startLine++;
        var len = lines[startLine].length;
        
        if(startColumn > len)
            startColumn = len;
            
        else if(startLine === anchorLine)
            startColumn = endColumn = anchorColumn;
    }
}

/*
 * Return the start and end columns of the selection relative to the passed line and character range
*/
- (JSObject)selectionForLine:(int)line range:(CPRange)range
{
    if(startLine === null)
        return NO;
    
    if(line < startLine || line > endLine)
        return NO;
        
    var isStartRange = line === startLine && TTLocationInRange(startColumn, range),
        isEndRange = line === endLine && TTLocationInRange(endColumn, range),
        isMiddleRange = NO;
              
    // lines between start and end lines
    if(line > startLine && line < endLine)
        isMiddleRange = YES;
        
    // start and end lines are the same
    if(startLine === endLine)
    {
        if(range.location >= startColumn && CPMaxRange(range) < endColumn)
            isMiddleRange = YES;
    }
    else
    {
        if(line === startLine) // starting line
            isMiddleRange = range.location >= startColumn;
            
        else if(line === endLine) // ending line
            isMiddleRange = CPMaxRange(range) < endColumn;
    }
    
    if(!isStartRange && !isMiddleRange && !isEndRange)
        return NO;
        
    var start = 0,
        end = range.length;
        
    if(isStartRange)
        start = startColumn - range.location;
    
    if(isEndRange)
        end = endColumn - range.location;
        
    return {
        start: start,
        end: end
    }
}

@end

// Like CPLocationInRange except that locations that === CPMaxRange(range) are concidered to be in the range
function TTLocationInRange(location, range)
{
    return (location >= range.location) && (location <= CPMaxRange(range));
}