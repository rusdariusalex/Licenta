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

@interface DARMainBLEViewController ()

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


@end
