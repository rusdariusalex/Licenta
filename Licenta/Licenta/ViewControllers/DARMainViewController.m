//
//  DARMainViewController.m
//  Foodie
//
//  Created by darius on 04/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARMainViewController.h"
#import "DARUser.h"
#import "UIFont+Additions.h"
#import "DARFinishOrderViewController.h"
#import "DARCategoryViewController.h"
#import "DARAccountSettingsViewController.h"
#import <Parse/Parse.h>
#import "DARSelectRestaurantViewController.h"

@interface DARMainViewController ()

@end

@implementation DARMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Create a NSUUID with the same UUID as the broadcasting beacon
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    
    // Setup a new region with that UUID and same identifier as the broadcasting beacon
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                             identifier:@"Estimote Region"];
    
    // Tell location manager to start monitoring for the beacon region
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
}

- (void)viewWillAppear:(BOOL)animated{
    self.welcomeLabel.font = [UIFont openSansSemiBoldWithSize:50];
    self.homeLabel.font = [UIFont openSansRegularWithSize:20];
    self.restaurantLabel.font = [UIFont openSansRegularWithSize:20];
    self.navigationController.navigationBarHidden = YES;
    self.restaurantView.alpha = 0.0;
    
    if (self.activeBeacon == nil) {
        [self showAtHomeView];
    }else{
        [self showAtRestaurantView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    [self.locationManager requestStateForRegion:self.myBeaconRegion];
}

- (void) locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    switch (state) {
        case CLRegionStateInside:
            [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
            
            break;
        case CLRegionStateOutside:
        default:
            // stop ranging beacons, etc
            NSLog(@"Region unknown");
    }
}

- (void) locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if ([beacons count] > 0) {
        for (CLBeacon *beacon in beacons) {
            if (beacon.proximity == CLProximityImmediate) {
                
                self.activeBeacon = beacon;
                
                self.table = [DARTable sharedInstance];
                if (![self.table.major isEqual:beacon.major]) {
                    
                    PFQuery *query = [PFQuery queryWithClassName:@"Table"];
                    [query whereKey:@"major" equalTo:beacon.major];
                    [query whereKey:@"minor" equalTo:beacon.minor];
                    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                        if (!error) {
                            
                            PFObject *object = [objects firstObject];
                            
                            self.table.restaurantName = [object objectForKey:@"restaurantName"];
                            self.table.tableNo = [object objectForKey:@"tableNo"];
                            self.table.major = [object objectForKey:@"major"];
                            self.table.minor = [object objectForKey:@"minor"];
                            
                            [self showAtRestaurantView];
                        }
                    }];

                }
            }else if (beacon.major == self.activeBeacon.major && beacon.proximity != CLProximityNear && beacon.proximity != CLProximityImmediate){
                [self.table resetInfo];
                self.activeBeacon = nil;
                
                [self showAtHomeView];
            }
        }
    }
}

- (void)showAtRestaurantView{
    self.restaurantLabel.text = [NSString stringWithFormat:@"You are at %@",self.table.restaurantName];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.homeLabel.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.homeView.alpha = 0.0;
            self.restaurantView.alpha = 1.0;
            self.restaurantLabel.alpha = 1.0;
        }];
    }];
}

- (void)showAtHomeView{
    self.restaurantLabel.text = @"";
    
    [UIView animateWithDuration:0.5 animations:^{
        self.restaurantLabel.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.restaurantView.alpha = 0.0;
            self.homeView.alpha = 1.0;
            self.homeLabel.alpha = 1.0;
            
        }];
    }];
}

- (IBAction)finishOrder:(id)sender {
    DARFinishOrderViewController *finishOrder  =[[DARFinishOrderViewController alloc] init];
    [self.navigationController pushViewController:finishOrder animated:YES];
}

- (IBAction)addItems:(id)sender {
    if (self.activeBeacon != nil) {
        DARCategoryViewController *categoryView = [[DARCategoryViewController alloc] init];
        [self.navigationController pushViewController:categoryView animated:YES];
    }else{
        DARSelectRestaurantViewController *selectRestaurant = [[DARSelectRestaurantViewController alloc] init];
        [self.navigationController pushViewController:selectRestaurant animated:YES];
    }

}

- (IBAction)accountSettings:(id)sender {
    DARAccountSettingsViewController *accountSettings = [[DARAccountSettingsViewController alloc] init];
    [self.navigationController pushViewController:accountSettings animated:YES];
}
@end
