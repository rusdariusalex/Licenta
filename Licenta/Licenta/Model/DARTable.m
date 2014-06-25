//
//  DARTable.m
//  Foodie
//
//  Created by darius on 25/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARTable.h"
#import <Parse/Parse.h>

@implementation DARTable

+ (DARTable*)sharedInstance;
{
    static DARTable *shared = nil;
    
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
        self.tableNo = @"";
        self.major = [NSNumber numberWithInt:0];
        self.minor = [NSNumber numberWithInt:0];
        self.restaurantName = @"";
    }
    return self;
}

- (void)resetInfo{
    self.tableNo = @"";
    self.major = [NSNumber numberWithInt:0];
    self.minor = [NSNumber numberWithInt:0];
    self.restaurantName = @"";
}

@end
