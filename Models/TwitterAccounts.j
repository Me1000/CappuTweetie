@import <Foundation/Foundation.j>

@implementation TwitterAccounts : CPObject
{
	CPMutableArray	accounts @accessors;
}

- (id)init
{
	self = [super init];
	accounts = [[CPMutableArray alloc] init];
}

- (void)addTwitterAccount:(TwitterAccount)aTwitterAccount
{
	[accounts addObject:aTwitterAccount];
}

@end