//
//  DAROrderItem.m
//  Foodie
//
//  Created by darius on 30/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DAROrderItem.h"
#import "DAROrder.h"

@implementation DAROrderItem

- (id)init {
    if ( (self = [super init]) ) {
        // your custom initialization
        self.menuItem = nil;
        self.quantity = [NSNumber numberWithInt:0];
    }
    return self;
}

- (void)addItem{
    DAROrder *order = [DAROrder sharedInstance];
    
    NSMutableArray *toDeleteObjects = [[NSMutableArray alloc] init];
    
    for (DAROrderItem *oriderItem in order.items) {
        if ([oriderItem.menuItem.name isEqualToString:self.menuItem.name]) {
            self.quantity = [NSNumber numberWithInt:([self.quantity intValue] + [oriderItem.quantity intValue])];
            
            [toDeleteObjects addObject:oriderItem];
        }
    }
    
    [order.items removeObjectsInArray:toDeleteObjects];
    
    [order.items addObject:self];
}

@end
