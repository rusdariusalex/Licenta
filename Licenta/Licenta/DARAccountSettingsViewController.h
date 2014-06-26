//
//  DARAccountSettingsViewController.h
//  Foodie
//
//  Created by darius on 25/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DARAccountSettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)logOut:(id)sender;

@end
