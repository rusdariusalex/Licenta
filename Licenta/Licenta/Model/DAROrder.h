//
//  DAROrder.h
//  Foodie
//
//  Created by darius on 30/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAROrderItem.h"
#import <Parse/Parse.h>

@interface DAROrder : NSObject

@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSNumber *totalPrice;
@property (strong, nonatomic) NSNumber *totalCalories;

+ (DAROrder*)sharedInstance;

- (void)totalPriceCalculate;
- (PFObject*)getPFObjectForOrder;
- (void)resetOrder;

@end
