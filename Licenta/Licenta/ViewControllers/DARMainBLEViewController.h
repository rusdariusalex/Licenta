//
//  DARMainBLEViewController.h
//  Foodie
//
//  Created by darius on 12/08/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DARTable.h"
#import <CoreBluetooth/CoreBluetooth.h>

#define n -42.119
//#define A -58.889
#define A -64.889

/*VALUE FOR FILTER RSSI*/
#define limitValueRSSI -30

/*VALUE FOR FILTER DISTANCE*/
#define limitValueDistance 200

@interface DARMainBLEViewController : UIViewController <CBCentralManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeLabel;
@property (weak, nonatomic) IBOutlet UIView *restaurantView;
@property (weak, nonatomic) IBOutlet UIView *homeView;

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral     *activeBeacon;
@property (nonatomic, strong) NSNumber         *activeBeaconRSSI;

@property (strong, nonatomic) DARTable *table;

@property BOOL homeOrRestaurant;


- (IBAction)finishOrder:(id)sender;
- (IBAction)addItems:(id)sender;
- (IBAction)accountSettings:(id)sender;


@end
