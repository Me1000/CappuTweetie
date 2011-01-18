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
    if(![usernames containsObject:[anAccount username]])
    {
        // TODO: actually perform twitter authentication
        [accounts addObject:anAccount];
        [[[CPApp delegate] sidebar] addAccount:anAccount];
        return true;
    }
    
    return false;
}

- (void)removeAccountAtIndex:(int)index
{
    [accounts removeObjectAtIndex:index];
    // TODO: remove account from sidebar
}

- (void)moveAccountAtIndex:(CPNumber)fromIndex toIndex:(CPNumber)toIndex
{
    var movedObject = [accounts objectAtIndex:fromIndex];
    [accounts removeObjectAtIndex:fromIndex];
    [accounts insertObject:movedObject atIndex:toIndex];
    // TODO: reorder accounts in the sidebar
}

@end