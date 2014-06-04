//
//  DARUser.h
//  Foodie
//
//  Created by darius on 04/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface DARUser : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *role;

+ (DARUser*)sharedInstance;
- (void)addUser:(NSString*)name email:(NSString*)email password:(NSString*)password address:(NSString*)address role:(NSString*)role;
- (void)setUser:(NSString*)name email:(NSString*)email password:(NSString*)password address:(NSString*)address role:(NSString*)role;

@end
