//
//  DARMainBLEViewController.m
//  Foodie
//
//  Created by darius on 12/08/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARMainBLEViewController.h"
#import "DARUser.h"
#import "UIFont+Additions.h"
#import "DARFinishOrderViewController.h"
#import "DARCategoryViewController.h"
#import "DARAccountSettingsViewController.h"
#import <Parse/Parse.h>
#import "DARSelectRestaurantViewController.h"

@interface DARMainBLEViewController (){
    NSMutableArray *rssiValues;
}

@end

@implementation DARMainBLEViewController

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
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], CBCentralManagerScanOptionAllowDuplicatesKey, nil];
    [self.centralManager scanForPeripheralsWithServices:nil options:options];
    
    rssiValues = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    self.welcomeLabel.font = [UIFont openSansSemiBoldWithSize:50];
    self.homeLabel.font = [UIFont openSansRegularWithSize:20];
    self.restaurantLabel.font = [UIFont openSansRegularWithSize:20];
    self.navigationController.navigationBarHidden = YES;
    self.restaurantView.alpha = 0.0;
    
    self.table = [DARTable sharedInstance];
    if ([self.table.restaurantName isEqualToString:@""]) {
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
    self.table = [DARTable sharedInstance];
    if (![self.table.restaurantName isEqualToString:@""]) {
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


#pragma mark - CBCentralManagerDelegate

// method called whenever you have successfully connected to the BLE peripheral
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{    
    if (self.activeBeacon && self.activeBeaconRSSI) {
        if (RSSI > self.activeBeaconRSSI) {
            self.activeBeacon = peripheral;
//            NSLog(@"%@ - %@", peripheral.identifier, RSSI);
            
            self.table = [DARTable sharedInstance];
            PFQuery *query = [PFQuery queryWithClassName:@"Table"];
            [query whereKey:@"identifier" equalTo:[peripheral.identifier UUIDString]];
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
        
        if ([peripheral.identifier isEqual:self.activeBeacon.identifier]) {
//            NSLog(@"%@ - %@", peripheral.identifier, RSSI);
            float rssi = [self filterRSSI:RSSI];
            //        NSLog(@"%@, %f",RSSI,rssi);
            double distance = [self calculateDistanceWithRSSI:rssi];
            
            if (distance > 1500) {
                [self.table resetInfo];
                [self showAtHomeView];
            }
        }
        
    }else{
        self.activeBeacon = peripheral;
        self.activeBeaconRSSI = [NSNumber numberWithInt:-60];
    }
}

// method called whenever the device state changes.
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            
            break;
            
        default:
            NSLog(@"nu e pornit");
            break;
    }
}

#pragma mark - RSSI

- (float)filterRSSI:(NSNumber*)RSSI{
    if (rssiValues.count <5) {
        [rssiValues addObject:RSSI];
    }else{
        [rssiValues removeObjectAtIndex:0];
        [rssiValues addObject:RSSI];
    }
    
    float media = 0;
    
    for (NSNumber *value in rssiValues) {
        media = media + [value floatValue];
    }
    
    media = media/rssiValues.count;
    
    return media;
}

-(double)calculateDistanceWithRSSI:(float) RSSI
{
    double frac =(A + RSSI);
    double distance=pow(10,frac/n);
//    NSLog(@"%f",distance);
    return distance;
}



@end
