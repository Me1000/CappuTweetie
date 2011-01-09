@import "../Controllers/ManageTwitterAccountsController.j"

@implementation PreferencesWindow : CPWindow
{
	id	manageTwitterAccountsController;
}

- (void)init
{
    self = [super initWithContentRect:CGRectMake(200, 200, 450, 260) styleMask:CPTitledWindowMask|CPClosableWindowMask|CPMiniaturizableWindowMask];
	
	[self setTitle:"Preferences"];
	
	// Just load the accounts prefs for now
	manageTwitterAccountsController = [[ManageTwitterAccountsController alloc] init];
	[self setTitle:"Accounts"];
	
	[[self contentView] addSubview:[manageTwitterAccountsController view]];
	 
	return self;
}

@end