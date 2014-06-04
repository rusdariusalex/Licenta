//
//  DARMainViewController.m
//  Foodie
//
//  Created by darius on 04/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARMainViewController.h"
#import "DARUser.h"

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
    DARUser *user = [DARUser sharedInstance];
    NSLog(@"%@",user.name);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
