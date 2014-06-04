//
//  DARUser.m
//  Foodie
//
//  Created by darius on 04/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARUser.h"

@implementation DARUser

+ (DARUser*)sharedInstance;
{
    static DARUser *shared = nil;
    
    @synchronized(shared)
    {
        if (!shared)
        {
            shared = [[super allocWithZone:nil] init];
        }
        
        return shared;
    }
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}
- (id)init {
    if ( (self = [super init]) ) {
        // your custom initialization
    }
    return self;
}

- (void)addUser:(NSString*)name email:(NSString*)email password:(NSString*)password address:(NSString*)address role:(NSString*)role{
    PFObject *user = [PFObject objectWithClassName:@"User"];
    user[@"name"] = name;
    user[@"email"] = email;
    user[@"password"] = password;
    user[@"address"] = address;
    user[@"role"] = role;
    
    [user saveInBackground];
}

- (void)setUser:(NSString*)name email:(NSString*)email password:(NSString*)password address:(NSString*)address role:(NSString*)role{
    self.name = name;
    self.email = email;
    self.password = password;
    self.address = address;
    self.role = role;
}


@end
