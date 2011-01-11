@import "AddAccountWindow.j"

@implementation PreferencesWindow : CPWindow
{
	//id	manageTwitterAccountsController;
	CPScrollView	accountsScrollView;
	CPTableView		accountsTable;
	CPSegmentedControl segControl;
}

- (void)init
{
    self = [super initWithContentRect:CGRectMake(200, 200, 450, 260) styleMask:CPTitledWindowMask|CPClosableWindowMask];
	[self center];
	
	var contentView = [self contentView];
	
	//[self setTitle:"Preferences"];
	
	// Just load the accounts prefs for now
	[self setTitle:"Accounts"];
	
	accountsScrollView = [[CPScrollView alloc] initWithFrame:CGRectMake(22, 22, 406, 190)];
	[accountsScrollView setAutohidesScrollers:YES];
	
	// Create and setup the table view
	accountsTable = [[CPTableView alloc] initWithFrame:[accountsScrollView bounds]];
	[accountsTable setDelegate:self];
	[accountsTable setHeaderView:nil];
	[accountsTable setCornerView:nil];
	[accountsTable setUsesAlternatingRowBackgroundColors:YES];
	[accountsTable setAllowsEmptySelection:YES];
	[accountsTable setVerticalMotionCanBeginDrag:YES];
	[accountsTable setDraggingDestinationFeedbackStyle:CPTableViewDropAbove];
	[accountsTable registerForDraggedTypes:["TwitterAccountDragType"]];
	
	var accountsColumn = [[CPTableColumn alloc] initWithIdentifier:"accounts"];
	[accountsColumn setWidth:403];
    [accountsTable addTableColumn:accountsColumn];	
	[accountsScrollView setDocumentView:accountsTable];
	[accountsTable setDataSource:self];
	
	var box = [CPBox boxEnclosingView:accountsScrollView];
	[contentView addSubview:box];
	
	// grabbed the images from CPButtonBar... not sure if they are right...
	segControl = [[CPSegmentedControl alloc] initWithFrame:CGRectMake(22, 222, 0, 25)];
	var plusImage = [[CPImage alloc] initWithContentsOfFile:[[CPBundle bundleForClass:[CPButtonBar class]] pathForResource:@"plus_button.png"] size:CGSizeMake(9, 10)],
	    minusImage = image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle bundleForClass:[CPButtonBar class]] pathForResource:@"minus_button.png"] size:CGSizeMake(9, 4)];
        
	[segControl setTrackingMode:CPSegmentSwitchTrackingMomentary];
	[segControl setTarget:self];
	[segControl setAction:@selector(segControlClicked:)];
	[segControl setSegmentCount:2];
	
	[segControl setImage:plusImage forSegment:0];
	[segControl setTag:"add" forSegment:0];
	[segControl setWidth:25 forSegment:0];
	
	[segControl setImage:minusImage forSegment:1];
	[segControl setTag:"remove" forSegment:1];
	[segControl setWidth:25 forSegment:1];
	[segControl setEnabled:NO forSegment:1];
	
	[contentView addSubview:segControl];
	
	// Create the tip text
	var tipText = [[CPTextField alloc] initWithFrame:CGRectMake(90, 226, 300, 20)];
	[tipText setTextColor:[CPColor colorWithHexString:@"333"]];
	[tipText setFont:[CPFont systemFontOfSize:11.5]];
	[tipText setStringValue:"You can reorder accounts by dragging."];
	[contentView addSubview:tipText];
	 
	return self;
}

- (void)segControlClicked:(id)sender
{
    var tag = [sender selectedTag];
    if(tag === "add")
    {
        [self showAddAccountSheet];
    }  
    else
    {
        var username = [[accountsController accounts] objectAtIndex:[accountsTable selectedRow]].username,
            message = "Are you sure you want to remove \"" + username + "\"?",
            alert = [[CPAlert alloc] init];
        
        [alert setMessageText:"Remove Account"];
        [alert setInformativeText:message];
        [alert setDelegate:self];
        [alert addButtonWithTitle:"Remove"];
        [alert addButtonWithTitle:"Cancel"];
        
        if([CPPlatform isBrowser])
            [alert beginSheetModalForWindow:self];
        else
            [alert runModal];
    }
}

- (void)alertDidEnd:(CPAlert)anAlert returnCode:(int)returnCode
{
    if(returnCode == 0)
    {
        [accountsController removeAccountAtIndex:[accountsTable selectedRow]];
        [accountsTable reloadData];
    }
}

- (void)showAddAccountSheet
{
    [AddAccountWindow showSheetForWindow:self];
}

- (void)addAccountWithUsername:(CPString)username password:(CPString)password
{
    var ok = [accountsController addAccount:[TwitterAccount accountWithUsername:username password:password]];
    if(ok)
    {
        [accountsTable reloadData];
    }
    else
    {
        var alert = [CPAlert alertWithError:"You cannot add the same account twice."];
        [alert runModal];
    }
    
    return ok;
}

- (int)numberOfRowsInTableView:(CPTableView)atableView
{
    return [accountsController accounts].length;
}

- (id)tableView:(CPTableView)aTableView objectValueForTableColumn:(CPTableColumn)aColumn row:(int)aRow
{
    return [[accountsController accounts] objectAtIndex:aRow].username;
}

- (void)tableViewSelectionDidChange:(CPNotification)aNotification
{
    var enabled = [accountsTable selectedRow] != CPNotFound;
    [segControl setEnabled:enabled forSegment:1];        
}

// drag and drop
- (BOOL)tableView:(CPTableView)aTableView writeRowsWithIndexes:(CPIndexSet)rowIndexes toPasteboard:(CPPasteboard)pboard
{
    // encode the index(es)being dragged
    var encodedData = [CPKeyedArchiver archivedDataWithRootObject:rowIndexes];
    [pboard declareTypes:["TwitterAccountDragType"] owner:self];
    [pboard setData:encodedData forType:"TwitterAccountDragType"];
    return YES;
}

- (CPDragOperation)tableView:(CPTableView)aTableView validateDrop:(id)info proposedRow:(CPInteger)row proposedDropOperation:(CPTableViewDropOperation)operation
{
    [aTableView setDropRow:row dropOperation:CPTableViewDropAbove];
    return CPDragOperationMove;
}

- (BOOL)tableView:(CPTableView)aTableView acceptDrop:(id)info row:(int)row dropOperation:(CPTableViewDropOperation)operation
{
    var pboard = [info draggingPasteboard],
        rowData = [pboard dataForType:"TwitterAccountDragType"];
        
    rowData = [CPKeyedUnarchiver unarchiveObjectWithData:rowData];
    var dropRow = [rowData firstIndex] < row ? row - 1 : row; // if we drop below the drag point we must subtract one
    [accountsController moveAccountAtIndex:[rowData firstIndex] toIndex:dropRow];
    
    [accountsTable reloadData];
    [accountsTable selectRowIndexes:[CPIndexSet indexSetWithIndex:dropRow] byExtendingSelection:NO];
    
    return YES;
}

@end