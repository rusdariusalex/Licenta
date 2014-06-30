//
//  DAROrder.m
//  Foodie
//
//  Created by darius on 30/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DAROrder.h"


@implementation DAROrder

+ (DAROrder*)sharedInstance;
{
    static DAROrder *shared = nil;
    
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
        
        self.items = [[NSMutableArray alloc] init];
        self.address = @"";
        self.user = @"";
        self.totalPrice = [NSNumber numberWithInt:0];
    }
    return self;
}

- (void)totalPriceCalculate{
    self.totalPrice = [NSNumber numberWithInt:0];
    self.totalCalories = [NSNumber numberWithInt:0];
    
    for (DAROrderItem *ordItem in self.items) {
        self.totalPrice = [NSNumber numberWithInt:([self.totalPrice intValue] + [ordItem.menuItem.price intValue] * [ordItem.quantity intValue])];
        self.totalCalories = [NSNumber numberWithInt:([self.totalCalories intValue] + [ordItem.menuItem.calories intValue] * [ordItem.quantity intValue])];
    }
}

- (PFObject*)getPFObjectForOrder{
    PFObject *order = [PFObject objectWithClassName:@"Order"];
    
    NSMutableArray *itemsToAdd = [[NSMutableArray alloc] init];
    
    for (DAROrderItem *orderItem in self.items) {
        NSMutableDictionary *ordItms = [[NSMutableDictionary alloc] init];
        
        [ordItms setObject:orderItem.quantity forKey:@"quantity"];
        [ordItms setObject:orderItem.menuItem.name forKey:@"name"];
        [ordItms setObject:orderItem.menuItem.price forKey:@"price"];
        
        [itemsToAdd addObject:ordItms];
    }
    
    order[@"items"] = itemsToAdd;
    
    order[@"address"] = self.address;
    order[@"user"] = self.user;
    order[@"userAssigned"] = @"";
    order[@"status"] = @"waiting";
    order[@"total"] = self.totalPrice;
    
    return order;
}

- (void)resetOrder{
    self.items = [[NSMutableArray alloc] init];
    self.address = @"";
    self.user = @"";
    self.totalPrice = [NSNumber numberWithInt:0];
}


@end
