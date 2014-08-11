//
//  DARUser.m
//  Foodie
//
//  Created by darius on 04/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARUser.h"

@implementation DARUser

+ (DARUser*)sharedInstance;
{
    static DARUser *shared = nil;
    
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
    }
    return self;
}

- (void)addUser:(NSString*)name email:(NSString*)email password:(NSString*)password address:(NSString*)address role:(NSString*)role height:(NSNumber*)height weight:(NSNumber*)weight age:(NSNumber*)age sex:(NSString*)sex{
    PFObject *user = [PFObject objectWithClassName:@"User"];
    user[@"name"] = name;
    user[@"email"] = email;
    user[@"password"] = password;
    user[@"address"] = address;
    user[@"role"] = role;
    user[@"height"] = height;
    user[@"weight"] = weight;
    user[@"age"] = age;
    user[@"sex"] = sex;
    
    [user saveInBackground];
}

- (void)setUser:(NSString*)name email:(NSString*)email password:(NSString*)password address:(NSString*)address role:(NSString*)role height:(NSNumber*)height weight:(NSNumber*)weight age:(NSNumber*)age sex:(NSString*)sex{
    self.name = name;
    self.email = email;
    self.password = password;
    self.address = address;
    self.role = role;
    self.height = height;
    self.weight = weight;
    self.age = age;
    self.sex = sex;
}

- (void)updateUserName:(NSString*)name address:(NSString*)address height:(NSNumber*)height weight:(NSNumber*)weight age:(NSNumber*)age sex:(NSString*)sex{
    
    self.name = name;
    self.address = address;
    self.height = height;
    self.weight = weight;
    self.age = age;
    self.sex = sex;
    
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query whereKey:@"email" equalTo:self.email];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            PFObject *object = [objects firstObject];
            
            object[@"name"] = name;
            object[@"address"] = address;
            object[@"height"] = height;
            object[@"weight"] = weight;
            object[@"age"] = age;
            object[@"sex"] = sex;
            
            [object saveInBackground];
        }
    }];
}

@end
