//
//  DARMenuItem.h
//  Foodie
//
//  Created by darius on 27/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DARMenuItem : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *photoURL;
@property (strong, nonatomic) NSNumber *calories;
@property (strong, nonatomic) NSNumber *price;

- (DARMenuItem*)menuItemWithName:(NSString*)name description:(NSString*)description photoURL:(NSString*)photURL calories:(NSNumber*)calories price:(NSNumber*)price;

@end
