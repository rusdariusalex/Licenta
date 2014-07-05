//
//  DAROrderForWaiter.h
//  Foodie
//
//  Created by darius on 03/07/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAROrderForWaiter : NSObject

@property (strong, nonatomic) NSString *orderId;
@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) NSString *userAssigned;
@property (strong, nonatomic) NSNumber *total;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *restaurant;

@end
