//
//  DARLogInViewController.h
//  Foodie
//
//  Created by darius on 02/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DARLogInViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIButton *showSignInButton;
@property (weak, nonatomic) IBOutlet UIButton *showSignUpButton;

@property (weak, nonatomic) IBOutlet UIView *signInView;
@property (weak, nonatomic) IBOutlet UIView *signUpView;
@property (weak, nonatomic) IBOutlet UIView *greyView;

@property (weak, nonatomic) IBOutlet UITextField *signUpNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *signUpEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *signUpPasswordTextField;

@property (weak, nonatomic) IBOutlet UITextField *signInEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *signInPasswordTextField;



- (IBAction)showSignIn:(id)sender;
- (IBAction)showSignUp:(id)sender;

- (IBAction)hideSignIn:(id)sender;
- (IBAction)hideSignUp:(id)sender;

- (IBAction)doSignUp:(id)sender;
- (IBAction)doSignIn:(id)sender;




@end
