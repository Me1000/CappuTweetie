@import <Foundation/Foundation.j>

@implementation TwitterAccount : CPObject
{
    CPString username @accessors;
    CPString password @accessors;
}

- (void)initWithUsername:(CPString)aUsername password:(CPString)aPassword
{
    self = [super init];
    
    username = aUsername;
    password = aPassword;
    
    return self;
}

// Convienience method...
+ (TwitterAccount)accountWithUsername:(CPString)aUsername password:(CPString)aPassword
{
    var account = [[TwitterAccount alloc] initWithUsername:aUsername password:aPassword];
    return account;
}

@end