//
//  DARMainBLEViewController.h
//  Foodie
//
//  Created by darius on 12/08/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DARTable.h"

@interface DARMainBLEViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeLabel;
@property (weak, nonatomic) IBOutlet UIView *restaurantView;
@property (weak, nonatomic) IBOutlet UIView *homeView;

@property (strong, nonatomic) DARTable *table;

@property BOOL homeOrRestaurant;


- (IBAction)finishOrder:(id)sender;
- (IBAction)addItems:(id)sender;
- (IBAction)accountSettings:(id)sender;


@end
