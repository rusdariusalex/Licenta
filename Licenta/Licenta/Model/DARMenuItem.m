//
//  DARMenuItem.m
//  Foodie
//
//  Created by darius on 27/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARMenuItem.h"

@implementation DARMenuItem

- (id)init {
    if ( (self = [super init]) ) {
        // your custom initialization
        self.name = @"";
        self.calories = [NSNumber numberWithInt:0];
        self.price = [NSNumber numberWithInt:0];
        self.description = @"";
        self.photoURL = @"";
    }
    return self;
}


- (DARMenuItem*)menuItemWithName:(NSString*)name description:(NSString*)description photoURL:(NSString*)photURL calories:(NSNumber*)calories price:(NSNumber*)price;{
    self.name = name;
    self.description = description;
    self.photoURL = photURL;
    self.calories = calories;
    self.price = price;
    
    return self;
}

@end
