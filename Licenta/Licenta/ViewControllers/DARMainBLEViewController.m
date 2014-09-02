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
    BOOL isFirst, isFirstDistance;
    NSNumber *filtruRSSI;
    int count;
    float number1,number2,number3,number4,number5;
    float distanceDevice;
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
}

- (void)viewWillAppear:(BOOL)animated{
    self.welcomeLabel.font = [UIFont openSansSemiBoldWithSize:50];
    self.homeLabel.font = [UIFont openSansRegularWithSize:20];
    self.restaurantLabel.font = [UIFont openSansRegularWithSize:20];
    self.navigationController.navigationBarHidden = YES;
    self.restaurantView.alpha = 0.0;
    
//    if (self.activeBeacon == nil) {
        [self showAtHomeView];
//    }else{
//        [self showAtRestaurantView];
//    }
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
//    if (self.activeBeacon != nil) {
//        DARCategoryViewController *categoryView = [[DARCategoryViewController alloc] init];
//        [self.navigationController pushViewController:categoryView animated:YES];
//    }else{
        DARSelectRestaurantViewController *selectRestaurant = [[DARSelectRestaurantViewController alloc] init];
        [self.navigationController pushViewController:selectRestaurant animated:YES];
//    }
    
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
            NSLog(@"%@ - %@", peripheral.identifier, RSSI);
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

-(void)calculateDistanceWithRSSI:(float) RSSI
{
    double frac =(A + RSSI);
    double distance=pow(10,frac/n);
    isFirstDistance = TRUE;
    [self filteringDistance:distance];
}

/*FILTER FOR  RSSI*/
-(void)filteringRSSI:(NSNumber*)RSSI
{
    NSNumber *limit =[[NSNumber alloc]initWithInt:limitValueRSSI];
    double a=([limit floatValue] +[filtruRSSI floatValue]);
    NSNumber *testADD =[NSNumber numberWithDouble:a];
    double b=([filtruRSSI floatValue] -[limit floatValue]);
    NSNumber *testSUB=[NSNumber numberWithDouble:b ];
    
    if (isFirst) {
        filtruRSSI=RSSI;
        isFirst=FALSE;
        //  NSLog(@"filteringRSSI first filtruRSSI(floatvalue) ->%f \n",[filtruRSSI floatValue]);
    }else{
        
        if(RSSI > testADD   && RSSI < testSUB )
        {
            double c=(([filtruRSSI floatValue]+[RSSI floatValue])/2);
            filtruRSSI=[NSNumber numberWithDouble:c];
            //  NSLog(@"filteringRSSI second filtruRSSI(floatValue) ->%f \n",[filtruRSSI floatValue]);
            
        }
        
    }
    count++;
    if (count==1) {
        number1=distanceDevice;
    }else if (count==2){
        number2=distanceDevice;
    }else if(count==3)
    {
        number3=distanceDevice;
    }
    else if(count==4)
    {
        number4=distanceDevice;
    }else if(count ==5 )
    {
        number5=distanceDevice;
        count=0;
        double rezultat =(number1+number2+number3+number4+number5)/5;
        NSLog(@"\n \t \t Dupa 5 modificari distanta este %f",rezultat);
        
    }
    
    
}

/*FILTER FOR DISTANCE*/
-(void)filteringDistance:(float)distance
{
    double a=(limitValueDistance +distanceDevice);
    double b=(distanceDevice-limitValueDistance);
    
    if (isFirstDistance) {
        distanceDevice=distance;
        isFirstDistance=FALSE;
        NSLog(@"filteringDistance first distanceDevice ->%f \n",distanceDevice);
        
        
    }else{
        
        if(distance > a   && distance < b )
        {
            
            double c=((distanceDevice+distance)/2);
            distanceDevice=c;
            NSLog(@"filteringDistance second distanceDevice ->%f \n",distanceDevice);
            
            
        }
        
    }
    
    
}

@end
