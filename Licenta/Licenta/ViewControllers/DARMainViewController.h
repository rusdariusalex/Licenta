//
//  DARMainViewController.h
//  Foodie
//
//  Created by darius on 04/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DARTable.h"

@interface DARMainViewController : UIViewController<CLLocationManagerDelegate>

@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeLabel;
@property (weak, nonatomic) IBOutlet UIView *restaurantView;
@property (weak, nonatomic) IBOutlet UIView *homeView;

@property (strong, nonatomic) DARTable *table;
@property (strong, nonatomic) CLBeacon *activeBeacon;

- (IBAction)finishOrder:(id)sender;
- (IBAction)addItems:(id)sender;
- (IBAction)accountSettings:(id)sender;



@end
