//
//  DARLogInViewController.h
//  Foodie
//
//  Created by darius on 02/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DARLogInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIButton *showSignInButton;
@property (weak, nonatomic) IBOutlet UIButton *showSignUpButton;

@property (weak, nonatomic) IBOutlet UIView *signInView;
@property (weak, nonatomic) IBOutlet UIView *signUpView;
@property (weak, nonatomic) IBOutlet UIView *greyView;


- (IBAction)showSignIn:(id)sender;
- (IBAction)showSignUp:(id)sender;



@end
