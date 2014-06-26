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
@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSNumber *weight;

+ (DARUser*)sharedInstance;
- (void)addUser:(NSString*)name email:(NSString*)email password:(NSString*)password address:(NSString*)address role:(NSString*)role height:(NSNumber*)height weight:(NSNumber*)weight;
- (void)setUser:(NSString*)name email:(NSString*)email password:(NSString*)password address:(NSString*)address role:(NSString*)role height:(NSNumber*)height weight:(NSNumber*)weight;
- (void)updateUserName:(NSString*)name address:(NSString*)address height:(NSNumber*)height weight:(NSNumber*)weight;

@end
