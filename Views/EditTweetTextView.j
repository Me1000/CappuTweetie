/*
 * EditTweetTextView.j
 * Created by Devon Govett
 *
 * This class is a canvas based text editor that does live highlighting of 
 * @mentions, #hashtags and links as the text is being edited.
 * It was created entirely from scratch on the HTML5 canvas element, 
 * and draws its own text selection, the blinking cursor, and even
 * performs its own word wrapping!  It manages common keyboard shortcuts 
 * used in text editing, and handles mouse clicking and dragging, as well as
 * cut, copy and paste.
 *
 */
 
/*
 * TODO:
 * fix word wrapping
 * implement undo/redo
 * better parsing
 * make the TweetWindow update the number of characters remaining
 * fix bugs
 */

@import <Foundation/CPAttributedString.j>
@import "TTCursor.j"
@import "TTSelection.j"

@implementation EditTweetTextView : CPControl
{
    CPArray lines @accessors;
    CPArray wrappedLines;
    CPArray parsedLines;
    CPArray wrappedLineIndexes;

    TTCursor cursor;
    TTSelection selection;
    
    CPColor mentionColor;
    CPColor hashtagColor;
    CPColor linkColor;
    CPColor linkBg;
    CPColor linkOutline;
    CPColor selectionColor;
    CPColor focusedSelectionColor;
    CPColor blurredSelectionColor;
    
    id timer;
    id delegate @accessors;
    
    CGContext measureContext;
    CPFont font @accessors;
}

- (id)initWithFrame:(CGRect)aRect
{
    self = [super initWithFrame:aRect];

    if (self)
    {
        cursor = [[TTCursor alloc] initWithTextView:self];
        selection = null;
        
        lines = [""]; // Plaintext lines
        wrappedLines = []; // Plaintext lines after word wrapping... might not stay...
        wrappedLineIndexes = [] // Keeps track of which lines in the wrappedLines array were wrapped vs. real lines
        parsedLines = []; // Parsed CPAttributedString lines
        
        // Text colors
        mentionColor = [CPColor colorWithHexString:"0f7fff"];
        hashtagColor = [CPColor colorWithHexString:"B3B3BC"];
        linkColor = [CPColor colorWithHexString:"063367"];
        linkBg = [CPColor colorWithHexString:"CCD9F2"];
        linkOutline = [CPColor colorWithHexString:"a4b0d3"];

        // Selection colors
        focusedSelectionColor = [CPColor colorWithRed:181/255 green:212/255 blue:255/255 alpha:1];
        blurredSelectionColor = [CPColor colorWithRed:212/255 green:212/255 blue:212/255 alpha:1];
        selectionColor = focusedSelectionColor;
        
        measureContext = CGBitmapGraphicsContextCreate(); // used for the measureText method...
        font = [CPFont systemFontOfSize:15];
        measureContext.font = [font cssString];
         
        _DOMElement.style.cursor = "text";               
        [cursor blink];
    }

    return self;
}

- (void)setStringValue:(CPString)aString
{
    [super setStringValue:aString];
    
    if(delegate) // tell the TweetWindow how many characters the user has left in this tweet
        [delegate setCharCount:140 - aString.length];
    
    // parse the string to make it sexy
    lines = aString.split('\n');
    [self parseLines];
    [self setNeedsDisplay:YES];
}

- (CPString)stringValue
{
    return lines.join('\n');
}

- (void)moveCursorToEnd
{
    [cursor moveToEnd:YES];
}

/*
 * Context menu support
 */
- (CPMenu)menu
{
    var menu = [[CPMenu alloc] initWithTitle:"Edit"],
        cutItem = [[CPMenuItem alloc] initWithTitle:"Cut" action:@selector(cut:) keyEquivalent:nil],
        copyItem = [[CPMenuItem alloc] initWithTitle:"Copy" action:@selector(copy:) keyEquivalent:nil];
        
    if(!selection)
    {
        [cutItem setEnabled:NO];
        [copyItem setEnabled:NO];
    }
        
    [menu addItem:cutItem];
    [menu addItem:copyItem];
    [menu addItemWithTitle:"Paste" action:@selector(paste:) keyEquivalent:nil];
    
    return menu;
}

/*
 * Parse the plain string value and mark @mentions, #hashtags, and links to be rendered differently
*/
- (void)parseLines
{
    var linkRe = /^(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])$/ig;
    parsedLines = [];
    
    //[self wrapLines]; // commented out until fixed...
    wrappedLines = lines;
    
    for(var i = 0, len = wrappedLines.length; i < len; i++)
    {
        var currentLine = wrappedLines[i],
            line = [[CPAttributedString alloc] initWithString:currentLine],
            words = currentLine.split(' '),
            index = 0;
            
        for(var j = 0, l = words.length; j < l; j++)
        {
            if(j > 0)
                index = currentLine.indexOf(' ', index + 1) + 1;
             
            var word = words[j],
                range = CPMakeRange(index, word.length);
                
            if(word == "")
            {
                index--;
                continue;
            }
                            
            if([word hasPrefix:"@"] && word.length > 1) // @mentions
            {
                [line addAttribute:"color" value:mentionColor range:range];
            }
            else if([word hasPrefix:"#"] && word.length > 1) // #hashtags
            {
                [line addAttribute:"color" value:hashtagColor range:range]
            }
            else if(linkRe.test(word)) // links
            {
                [line addAttribute:"color" value:linkColor range:range];
                [line addAttribute:"link" value:YES range:range];
            }
        }
        
        [parsedLines addObject:line];
    }
}

/*
 * Wraps the plaintext lines to fit within the text view horizontally
 */
 
// FIXME devongovett: this is broken...
- (void)wrapLines
{
    var maxWidth = CGRectGetWidth([self frame]) - 16,
        spaceWidth = measureContext.measureText(' ').width;
    
    // not sure if this is *really* how I want to do this...
    wrappedLines = [];
    wrappedLineIndexes = [];
    
    for(var i = 0, len = lines.length; i < len; i++)
    {
        var currentLine = lines[i],
            words = currentLine.split(' '),
            spaceLeft = maxWidth,
            line = [];
            
        for(var j = 0, wordLen = words.length; j < wordLen; j++)
        {
            var word = words[j],
                width = measureContext.measureText(word).width;
                
            if(width > spaceLeft)
            {
                wrappedLines.push(line.join(' '));
                line = [word];
                wrappedLineIndexes.push(wrappedLines.length);
                spaceLeft = maxWidth - width;
            }
            else
            {
                spaceLeft -= width + spaceWidth;
                line.push(word);
            }
        }
        
        wrappedLines.push(line.join(' '));
    }
}

/*
 * The main drawing method.  This draws all lines with styling for the parsed sections, the selection, and the blinking cursor.
*/
- (void)drawRect:(CPRect)aRect
{
    var context = [[CPGraphicsContext currentContext] graphicsPort],
        cursorX = 8,
        cursorY = 8 + [cursor line] * 20,
        showCursor = [cursor showing],
        dy = 0,
        maxWidth = CGRectGetWidth([self frame]) - 16,
        extraRuns = [];
                        
    context.font = [font cssString];
    context.textBaseline = "top";
    
    for(var i = 0, len = parsedLines.length; i < len; i++)
    {
        var range = CPMakeRange(0, 0),
            index = 0,
            attrString = parsedLines[i],
            string = [attrString string],
            length = [string length],
            dx = 0;
            
        while(index < length)
        {
            var attributes = [attrString attributesAtIndex:index effectiveRange:range],
                color = [attributes objectForKey:"color"] || [CPColor blackColor],
                isLink = [attributes objectForKey:"link"] || NO,
                run = [string substringWithRange:range],
                width = context.measureText(run).width;
            
            // Draw link background                                                
            if(isLink)
            {
                var rect = CGRectMake(8 + dx - 2, 8 + dy - 1, width + 4, 16 + 4),
                    path = [CPBezierPath bezierPath];
                    
                [path appendBezierPathWithRoundedRect:rect xRadius:5 yRadius:5];
                CGContextSetFillColor(context, linkBg);
                [path fill];
            }
            
            // Draw selection...
            var sel = null;
            if(selection && (sel = [selection selectionForLine:i range:range]))
            {
                var selectionWidth = width,
                    selectionX = dx;
                    
                if(sel.start > 0)
                {
                    var sub = run.substring(0, sel.start),
                        cw = context.measureText(sub).width;
                        
                    selectionX += cw;
                    selectionWidth -= cw;
                }
                
                if(sel.end < range.length)
                {
                    var sub = run.substring(sel.end);
                    selectionWidth -= context.measureText(sub).width;
                }
                    
                CGContextSetFillColor(context, selectionColor);
                CGContextFillRect(context, CGRectMake(8 + selectionX, 8 + dy - 1, selectionWidth, 20));
            }
            
            // Draw text    
            CGContextSetFillColor(context, color);
            context.fillText(run, 8 + dx, 8 + dy);
             
            // Figure out the cursor x position...            
            var col = [cursor column],
                max = CPMaxRange(range);
               
            if(showCursor && [cursor line] == i && (CPLocationInRange(col, range) || col == max))
            {
                cursorX = 8 + dx;
                
                var col = [cursor column];
                if(col > range.location && col < max)
                {
                    var substr = [run substringWithRange:CPMakeRange(0, col - range.location)];
                    cursorX += context.measureText(substr).width;
                }
                else if(col == max)
                {
                    cursorX += width
                }
            }
            
            index = CPMaxRange(range);
            dx += width;
        }
        
        // Draw extra selection box if the selection extends beyond the current line
        if(selection && i >= [selection startLine] && i < [selection endLine])
        {
            CGContextSetFillColor(context, selectionColor);
            CGContextFillRect(context, CGRectMake(8 + dx, 8 + dy - 1, maxWidth - dx, 20));
        }
        
        dy += 20;
    }
    
    // Draw cursor
    if(showCursor)
    {
        CGContextSetFillColor(context, [CPColor blackColor]);
        CGContextFillRect(context, CGRectMake(cursorX, cursorY, 1, 16 + 2));
    }
}

// Focused/blurred state - called by NewTweetWindow

- (void)focus
{
    if(selection)
    {
        selectionColor = focusedSelectionColor;
        [self setNeedsDisplay:YES];
    }
    else
        [cursor blink];
}

- (void)blur
{
    if(selection)
    {
        selectionColor = blurredSelectionColor;
        [self setNeedsDisplay:YES];
    }
    else
    {
        [cursor stopBlinking];
        [cursor hide];
    }
}

// Keyboard events

- (BOOL)acceptsFirstResponder
{
    return YES;
}

- (void)keyDown:(CPEvent)anEvent
{
    [cursor stopBlinking];
    [self interpretKeyEvents:[anEvent]];
}

- (void)keyUp:(CPEvent)anEvent
{
    if(!selection)
        [cursor blink];
}

- (void)insertText:(CPString)characters
{
    if(selection)
        [self deleteSelection];
    
    var cl = [cursor line],
        line = [lines objectAtIndex:cl];
        
    lines[cl] = [line stringByReplacingCharactersInRange:CPMakeRange([cursor column], 0) withString:characters];
    
    [self parseLines];
    [cursor moveRight:NO];
}

/*
 * Returns the column of the word before the cursor
*/
// TODO: move between lines also...
- (void)previousWordColumn
{
    var lineIndex = [cursor line],
        line = lines[lineIndex],
        ei = [cursor column],
        si = ei - 1,
        c = line.charAt(si);
        
    if(line.length === 0 || si <= 0)
        return NO;
    
    // Remove leading spaces
    while(si > 0 && c === " ")
        c = line.charAt(si--);
    
    // Go back until another " " is detected
    while(si && c !== " ")
        c = line.charAt(si--);
    
    return si ? si + 2 : 0;
}

/*
 * Returns the column of the next word after the cursor
*/
// TODO: move between lines also...
- (void)nextWordColumn
{
    var lineIndex = [cursor line],
        line = lines[lineIndex],
        len = line.length,
        si = [cursor column],
        ei = si + 1,
        c = line.charAt(ei);
        
    if(len === 0 || si === len)
        return NO;
    
    // Remove leading spaces
    while(ei < len && c === " ") 
        c = line.charAt(ei++);
        
    // Go foreward until another " " is detected
    while(ei < len && c !== " ")
        c = line.charAt(ei++);
    
    return ei === len ? ei : ei - 1;
}

// Arrow key methods...

- (void)moveLeft:(id)sender
{
    if(selection)
        selection = [cursor takeFromSelection:selection position:TTCursorSelectionStart];
    else
        [cursor moveLeft:YES];
}

- (void)moveRight:(id)sender
{
    if(selection)
        selection = [cursor takeFromSelection:selection position:TTCursorSelectionEnd];
    else
        [cursor moveRight:YES];
}

- (void)moveUp:(id)sender
{
    if(selection)
        selection = [cursor takeFromSelection:selection position:TTCursorSelectionStart];
    
    [cursor moveUp:YES];
}

- (void)moveDown:(id)sender
{
    if(selection)
        selection = [cursor takeFromSelection:selection position:TTCursorSelectionEnd];
    
    [cursor moveDown:YES];
}

- (void)moveWordLeft:(id)sender
{
    if(selection)
        selection = [cursor takeFromSelection:selection position:TTCursorSelectionStart];
    
    var column = [self previousWordColumn];
    if(column !== NO)
        [cursor setColumn:column];
}

- (void)moveWordRight:(id)sender
{
    if(selection)
        selection = [cursor takeFromSelection:selection position:TTCursorSelectionEnd];
    
    var column = [self nextWordColumn];
    if(column !== NO)
        [cursor setColumn:column];
}

- (void)moveLeftAndModifySelection:(id)sender
{
    if(!selection)
        selection = [[TTSelection alloc] initWithAnchor:cursor];
    
    [selection extendLeft:1 lines:lines];
    
    if([selection hasNoLength])
        selection = null;
    else
        [cursor hide];
}

- (void)moveRightAndModifySelection:(id)sender
{
    if(!selection)
        selection = [[TTSelection alloc] initWithAnchor:cursor];
    
    [selection extendRight:1 lines:lines];
    
    if([selection hasNoLength])
        selection = null;
    else
        [cursor hide];
}

- (void)moveUpAndModifySelection:(id)sender
{
    if(!selection)
        selection = [[TTSelection alloc] initWithAnchor:cursor];
    
    [selection extendUp:lines];
    
    if([selection hasNoLength])
        selection = null;
    else
        [cursor hide];
}

- (void)moveDownAndModifySelection:(id)sender
{
    if(!selection)
        selection = [[TTSelection alloc] initWithAnchor:cursor];
    
    [selection extendDown:lines];
    
    if([selection hasNoLength])
        selection = null;
    else
        [cursor hide];
}

- (void)moveWordLeftAndModifySelection:(id)sender
{
    // TODO: implement
}

- (void)moveWordRightAndModifySelection:(id)sender
{
    // TODO: implement
}

- (void)moveToLeftEndOfLineAndModifySelection:(id)sender
{
    if(!selection)
        selection = [[TTSelection alloc] initWithAnchor:cursor];
    
    [selection extendToLine:[cursor line] column:0];
    [cursor hide];
    
    [[[self window] platformWindow] _propagateCurrentDOMEvent:NO];
}

- (void)moveToRightEndOfLineAndModifySelection:(id)sender
{
    if(!selection)
        selection = [[TTSelection alloc] initWithAnchor:cursor];
    
    var line = lines[[cursor line]];
    [selection extendToLine:[cursor line] column:line.length];
    [cursor hide];
    
    [[[self window] platformWindow] _propagateCurrentDOMEvent:NO];
}

// Backspace/delete key support...

/*
 * Deletes the characters in the passed range from the line at the given index
*/
- (void)deleteRange:(CPRange)aRange fromLine:(int)aLine
{
    lines[aLine] = [lines[aLine] stringByReplacingCharactersInRange:aRange withString:""];
}

/*
 * Merges the lines at the passed indexes
*/
- (void)mergeLine:(int)startLine withLine:(int)endLine
{
    lines[startLine] += lines[endLine];
    [lines removeObjectAtIndex:endLine];
}

/*
 * Deletes the text that is currently selected and moves the cursor accordingly.
*/
- (void)deleteSelection
{
    if(selection)
    {
        var sl = [selection startLine],
            sc = [selection startColumn],
            el = [selection endLine],
            ec = [selection endColumn],
            startingLine = [lines objectAtIndex:sl],
            endingLine = [lines objectAtIndex:el];
            
        if(sl === el)
        {
            lines[sl] = [startingLine stringByReplacingCharactersInRange:CPMakeRange(sc, ec - sc) withString:""];
        }
        else
        {
            // delete characters from starting and ending lines
            lines[sl] = [startingLine stringByReplacingCharactersInRange:CPMakeRange(sc, startingLine.length - sc) withString:""];
            lines[el] = [endingLine stringByReplacingCharactersInRange:CPMakeRange(0, ec) withString:""];
            
            // merge starting and ending lines
            lines[sl] += lines[el];
            
            // remove lines between starting and ending lines
            [lines removeObjectsInRange:CPMakeRange(sl + 1, el - sl)];
        }
        
        [cursor setLine:sl];
        [cursor setColumn:sc];
        selection = null;
    }
}

- (void)deleteBackward:(id)sender
{    
    if(selection)
    {
        [self deleteSelection];
    }
    else
    {
        var cl = [cursor line];
            
        if([cursor column] === 0 && [cursor line] > 0)
        {
            [cursor setLine:cl - 1];
            [cursor setColumn:lines[cl - 1].length + 1];
            [self mergeLine:cl - 1 withLine:cl];
        }
        else
        {
            [self deleteRange:CPMakeRange([cursor column] - 1, 1) fromLine:cl];
        }
            
        [cursor moveLeft:NO];
    }
    
    [self parseLines];
}

- (void)deleteForward:(id)sender
{
    if(selection)
    {
        [self deleteSelection];
    }
    else
    {
        var cl = [cursor line],
            line = lines[cl],
            len = lines.length;
        
        if([cursor column] === len && [cursor line] < len - 1)
            [self mergeLine:cl withLine:cl + 1];
            
        else
            [self deleteRange:CPMakeRange([cursor column], 1) fromLine:cl];
    }
    
    [self parseLines];
}

- (void)deleteWordBackward:(id)sender
{
    if(selection)
    {
        [self deleteSelection];
    }
    else
    {
        var si = [self previousWordColumn],
            ei = [cursor column];
        
        [self deleteRange:CPMakeRange(si, ei - si) fromLine:[cursor line]];
        [cursor setColumn:si];
    }
    
    [self parseLines];
}

- (void)deleteWordForward:(id)sender
{
    if(selection)
    {
        [self deleteSelection];
    }
    else
    {
        var si = [cursor column],
            ei = [self nextWordColumn];
            
        [self deleteRange:CPMakeRange(si, ei - si) fromLine:[cursor line]];
    }
    
    [self parseLines];
}

- (void)deleteToBeginningOfLine:(id)sender
{
    [[[self window] platformWindow] _propagateCurrentDOMEvent:NO]; // don't let the browser go back...
    
    if(selection)
    {
        [self deleteSelection];
    }
    else
    {
        [self deleteRange:CPMakeRange(0, [cursor column]) fromLine:[cursor line]]    
        [cursor setColumn:0];
        [cursor blink]; // preventing DOM propagation prevents keyUp...
    }
    
    [self parseLines];
}

- (void)insertNewline:(id)sender
{
    if(selection)
        [self deleteSelection];
        
    var cl = [cursor line],
        col = [cursor column],
        line = [lines objectAtIndex:cl],
        newline = col === line.length ? "" : line.substring(col);
        
    if(col !== line.length)
        [self deleteRange:CPMakeRange(col, line.length) fromLine:cl];
        
    [lines insertObject:newline atIndex:cl + 1];
    [self parseLines];
    
    [cursor setLine:cl + 1];
    [cursor setColumn:0];
}

// Copy/paste

- (void)copy:(id)sender
{
    if(selection)
    {
        var sl = [selection startLine],
            sc = [selection startColumn],
            el = [selection endLine],
            ec = [selection endColumn],
            startingLine = [lines objectAtIndex:sl],
            endingLine = [lines objectAtIndex:el],
            value = "";

        if(sl === el)
        {
            value = [startingLine substringWithRange:CPMakeRange(sc, ec - sc)];
        }
        else
        {
            value = [startingLine substringWithRange:CPMakeRange(sc, startingLine.length)];

            if(el > sl + 1)
            {
                var middleLines = lines.slice(sl + 1, el);
                value += '\n' + middleLines.join('\n');
            }

            value += '\n' + [endingLine substringWithRange:CPMakeRange(0, ec)];
        }

        var pasteboard = [CPPasteboard generalPasteboard];
        [pasteboard declareTypes:[CPStringPboardType] owner:nil];
        [pasteboard setString:value forType:CPStringPboardType];
    }
}

- (void)cut:(id)sender
{
    [self copy:sender];
    [self deleteSelection];
    [self parseLines];
    [cursor blink];
    [self setNeedsDisplay:YES];
}

- (void)paste:(id)sender
{
    var pasteboard = [CPPasteboard generalPasteboard];
    if (![[pasteboard types] containsObject:CPStringPboardType])
        return;
        
    var pasteString = [pasteboard stringForType:CPStringPboardType],
        pasteLines = pasteString.split('\n'),
        len = pasteLines.length;
       
    if(selection)
    {
        [self deleteSelection];
        [cursor blink];
    }
        
    var sl = [cursor line],
        sc = [cursor column],
        startLine = lines[sl];
    
    // Move text after the cursor to the end of the last pasted line   
    var endText = startLine.substring(sc);
    [self deleteRange:CPMakeRange(sc, startLine.length) fromLine:sl];
    
    // Append the first line of the pasted text to startLine   
    lines[sl] = [lines[sl] stringByReplacingCharactersInRange:CPMakeRange(sc, 0) withString:pasteLines[0]];
    
    [cursor setLine:sl + len - 1];
    [cursor setColumn:sc + pasteLines[0].length];
    
    if(len > 1)
    {
        // Insert the last line of the pasted text at the beginning of the last line
        if(sl + 1 < lines.length)
            lines[sl + 1] = [lines[sl + 1] stringByReplacingCharactersInRange:CPMakeRange(0, 0) withString:pasteLines[len - 1]];
       
        // Insert the pasted lines between the first and end lines
        for(var i = 1; i < len; i++)
            [lines insertObject:pasteLines[i] atIndex:sl + i];
        
        [cursor setColumn:pasteLines[len - 1].length];
    }
    
    // Add the extra text back on...
    lines[sl + len - 1] += endText;
        
    [self parseLines];
    [self setNeedsDisplay:YES];
}

- (void)selectAll:(id)sender
{
    if(!selection)
        selection = [[TTSelection alloc] initWithAnchor:cursor];
        
    var len = lines.length - 1,
        lineLength = lines[len].length;
        
    [selection setStartLine:0];
    [selection setStartColumn:0];
    
    [selection setEndLine:len];
    [selection setEndColumn:lineLength];
                
    [cursor hide];
    [[[self window] platformWindow] _propagateCurrentDOMEvent:NO];
}

// Mouse support

- (void)mouseDown:(CPEvent)event
{
    var point = [self convertPoint:[event locationInWindow] fromView:nil],
        cursorPosition = [self cursorPositionFromPoint:point],
        clickCount = [event clickCount];
        
    [cursor setLine:cursorPosition.line];
    [cursor setColumn:cursorPosition.column];
    
    if(clickCount === 1) // Move cursor
    {
        selection = null;
        [cursor stopBlinking];
    }
    else if(clickCount === 2) // Select word
    {
        var lineIndex = cursorPosition.line,
            line = lines[lineIndex],
            len = line.length,
            si = cursorPosition.column,
            ei = si,
            c = "";
            
        // Go back until a " " is detected
        while(si && c !== " ")
            c = line.charAt(si--);
        
        si = si ? si + 2 : 0;
        
        // Go forward until a " " is detected
        c = "";
        while(ei < len && c !== " ")
            c = line.charAt(ei++);
        
        ei = (ei === len && c !== " ") ? ei : ei - 1;
        
        selection = [[TTSelection alloc] initWithAnchorLine:lineIndex column:si];
        [selection extendToLine:lineIndex column:ei];
        [cursor hide];
    }
    else if(clickCount === 3) // Select entire line
    {
        var lineIndex = cursorPosition.line,
            line = lines[lineIndex];
            
        selection = [[TTSelection alloc] initWithAnchorLine:lineIndex column:0];
        [selection extendToLine:lineIndex column:line.length];
        [cursor hide];
    }
}

- (void)mouseDragged:(CPEvent)event
{
    var point = [self convertPoint:[event locationInWindow] fromView:nil],
        cursorPosition = [self cursorPositionFromPoint:point];
        
    [cursor hide];
        
    if(!selection)
    {
        selection = [[TTSelection alloc] initWithAnchor:cursor];
    }
    else
    {
        var showCursor = [selection extendToCursorPosition:cursorPosition];
        if(showCursor)
            [cursor show];
    }
    
    [self setNeedsDisplay:YES];
}

- (void)mouseUp:(CPEvent)event
{
    if([selection hasNoLength])
        selection = null;
    
    if(!selection)
        [cursor blink];
}

/*
 * Returns the line and column of the cursor at the given point
*/
- (JSObject)cursorPositionFromPoint:(CPPoint)point
{

    if(lines.length == 0)
        return;
    
    // find the line that was clicked on
    var clickedLine = MAX(0, MIN(wrappedLines.length - 1, ROUND((point.y - 16) / 20))),
        line = wrappedLines[clickedLine],
        x = point.x - 8,
        min = 0,
        max = line.length,
        pos = max;
        
    // find the character that was clicked on   
    while(min < max)
    {
        var mid = min + ROUND((max - min) / 2),
            sub = line.substring(0, mid),
            width = measureContext.measureText(sub).width;
            
        if(max - min === 1) // Match!
        {
            //Figure out which half of the character was clicked on
            pos = MAX(0, mid);
            var c = line.charAt(pos),
                cw = measureContext.measureText(c).width;
               
            if(x < width - (cw / 2))
				pos--;
				
            break;
        }
        
        if(x < width) 
			max = mid;
		else 
			min = mid;
    }
    
    // Convert wrapped lines to physical lines
    // If the line was a wrapped line, subtract one from the line index until the first line is reached
    //while(clickedLine && [wrappedLineIndexes containsObject:clickedLine])
    //    pos += wrappedLines[clickedLine--].length + 1;
                
    return {
        line: clickedLine,
        column: pos,
    }
}

@end