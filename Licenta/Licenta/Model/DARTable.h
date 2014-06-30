//
//  DARTable.h
//  Foodie
//
//  Created by darius on 25/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DARTable : NSObject

@property (strong, nonatomic) NSString *tableNo;
@property (strong, nonatomic) NSString *restaurantName;
@property (strong, nonatomic) NSString *offlineRestaurantName;
@property (strong, nonatomic) NSMutableArray *menu;
@property (strong, nonatomic) NSNumber *major;
@property (strong, nonatomic) NSNumber *minor;

+ (DARTable*)sharedInstance;

- (void)resetInfo;

@end
