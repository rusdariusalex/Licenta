//
//  DAROrderItem.h
//  Foodie
//
//  Created by darius on 30/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DARMenuItem.h"

@interface DAROrderItem : NSObject

@property (strong, nonatomic) DARMenuItem *menuItem;
@property (strong, nonatomic) NSNumber *quantity;

- (void)addItem;

@end
