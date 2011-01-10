@implementation AccountController : CPObject
{
    CPArray accounts @accessors;
}

- (void)init
{
    self = [super init];
    accounts = [];
    return self;
}

- (void)addAccount:(TwitterAccount)anAccount
{
    var usernames = [accounts valueForKey:"username"];
    if([usernames containsObject:[anAccount username]])
    {
        var alert = [CPAlert alertWithError:"You cannot add the same account twice."];
        [alert runModal]; // not sure why this isn't draggable and the OK button isn't clickable (me1000?)
    }
    else
        [accounts addObject:anAccount];
        // TODO: add account to sidebar
}

- (void)removeAccountAtIndex:(int)index
{
    [accounts removeObjectAtIndex:index];
    // TODO: remove account from sidebar
}

@end