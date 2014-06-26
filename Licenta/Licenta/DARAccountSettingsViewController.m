//
//  DARAccountSettingsViewController.m
//  Foodie
//
//  Created by darius on 25/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARAccountSettingsViewController.h"
#import "DARMainViewController.h"
#import "DARUser.h"
#import "UIFont+Additions.h"

@interface DARAccountSettingsViewController (){
    DARUser *user;
}

@end

@implementation DARAccountSettingsViewController

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
    
    user = [DARUser sharedInstance];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.emailLabel.text = user.email;
    self.emailLabel.font = [UIFont openSansRegularWithSize:20];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    
    for (id viewController in [self.navigationController viewControllers]){
        if ([viewController isKindOfClass:[DARMainViewController class]])
        {
            [self.navigationController popToViewController:viewController animated:YES];
            break;
        }
    }
}

- (IBAction)logOut:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
