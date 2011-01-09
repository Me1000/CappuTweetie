@implementation ManageTwitterAccountsController : CPViewController 
{
	CPScrollView	accountsScrollView;
	CPTableView		accountsTableView;
	CPView			accountsScrollViewOuterBorder;
	CPButton		addAccountButton;
	CPButton		removeAccountButton;
	CPWindow		addAccountModalWindow;
}	

- (void)init
{	
	self = [super init];
	var manageView = [[CPView alloc] initWithFrame:CGRectMake( 0, 0, 450, 260 )];
	
	// Create and setup the scrollview
	[accountsScrollViewOuterBorder = [[CPView alloc] initWithFrame:CGRectMake( 22, 22, 406, 190 )]];
	[accountsScrollViewOuterBorder setBackgroundColor:[CPColor colorWithHexString:@"BBB"]];
	
	accountsScrollView = [[CPScrollView alloc] initWithFrame:CGRectMake( 1, 1, 404, 188 )];
	[accountsScrollView setAutohidesScrollers:YES];
	[accountsScrollViewOuterBorder addSubview:accountsScrollView];
	
	// Create and setup the table view
	accountsTableView = [[CPTableView alloc] initWithFrame:[accountsScrollView bounds]];
	[accountsTableView setHeaderView:nil];
	[accountsTableView setCornerView:nil];
	[accountsTableView setUsesAlternatingRowBackgroundColors:YES];
	
	// Create the add / remove buttons
	addAccountButton = [[CPButton alloc] initWithFrame:CGRectMake( 22, 222, 26, 20 )];
	[addAccountButton setTitle:@"+"];
	[addAccountButton setTarget:self];
	[addAccountButton setAction:@selector(showAddAccountModal:)];

	removeAccountButton = [[CPButton alloc] initWithFrame:CGRectMake( 48, 222, 26, 20 )];
	[removeAccountButton setTitle:@"-"];
	
	
	// Create the tip text
	var tipText = [[CPTextField alloc] initWithFrame:CGRectMake( 90, 222, 300, 20 )];
	[tipText setTextColor:[CPColor colorWithHexString:@"333"]];
	[tipText setFont:[CPFont systemFontOfSize:11.5]];
	[tipText setStringValue:@"You can reorder accounts by dragging."]
	
	// Create the add account modal view
	var addAccountModalView = [[CPView alloc] initWithFrame:CGRectMake(0, 0, 330, 130)];
	
	addAccountModalWindow = [[CPWindow alloc] initWithContentRect:[addAccountModalView bounds] styleMask:CPDocModalWindowMask];
	
	[manageView addSubview:accountsScrollViewOuterBorder];
	[accountsScrollView setDocumentView:accountsTableView];
	
	[manageView addSubview:removeAccountButton];
	[manageView addSubview:addAccountButton];
	[manageView addSubview:tipText];
	
	[self setView:manageView];
	
	return self;
}

- (void)showAddAccountModal:(id)sender
{
	[CPApp beginSheet:addAccountModalWindow modalForWindow:[[self view] window] modalDelegate:self didEndSelector:@selector(_alertDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

@end;