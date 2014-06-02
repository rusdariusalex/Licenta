//
//  DARLogInViewController.m
//  Foodie
//
//  Created by darius on 02/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARLogInViewController.h"
#import "POP.h"


@interface DARLogInViewController (){
    UIGestureRecognizer *dismissKeyboard;
}

@end

@implementation DARLogInViewController

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
    
    self.showSignInButton.alpha = 0.0;
    self.showSignUpButton.alpha = 0.0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.signInEmailTextField.delegate = self;
    self.signInPasswordTextField.delegate = self;
    self.signUpEmailTextField.delegate = self;
    self.signUpNameTextField.delegate = self;
    self.signUpPasswordTextField.delegate = self;
    
    dismissKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.greyView addGestureRecognizer:dismissKeyboard];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.signInView.frame = CGRectMake(self.signInView.frame.origin.x, 568, self.signInView.frame.size.width, self.signInView.frame.size.height);
    self.signUpView.frame = CGRectMake(self.signUpView.frame.origin.x, 568, self.signUpView.frame.size.width, self.signUpView.frame.size.height);
    
    self.signInView.layer.masksToBounds = YES;
    self.signUpView.layer.masksToBounds = YES;
    self.signInView.layer.cornerRadius = 20;
    self.signUpView.layer.cornerRadius = 20;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.0
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                     
                         self.logo.frame = CGRectMake(self.logo.frame.origin.x, 120, self.logo.frame.size.width, self.logo.frame.size.height);
                         
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.4 animations:^{
                         
                             self.showSignInButton.alpha = 1.0;
                             self.showSignUpButton.alpha = 1.0;
                         }];
                         
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showSignIn:(id)sender {
    [self.view endEditing:YES];
    
    POPSpringAnimation *popOutAnimation = [POPSpringAnimation animation];
    popOutAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    
    popOutAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(self.signInView.frame.origin.x, 218, self.signInView.frame.size.width, self.signInView.frame.size.height)];
    popOutAnimation.springBounciness = 10.0;
    popOutAnimation.springSpeed = 10.0;
    
    [self.signInView pop_addAnimation:popOutAnimation forKey:@"pop"];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.greyView.alpha = 0.6;
    }];
}

- (IBAction)showSignUp:(id)sender {
    [self.view endEditing:YES];
    
    POPSpringAnimation *popOutAnimation = [POPSpringAnimation animation];
    popOutAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    
    popOutAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(self.signInView.frame.origin.x, 218, self.signInView.frame.size.width, self.signInView.frame.size.height)];
    popOutAnimation.springBounciness = 10.0;
    popOutAnimation.springSpeed = 10.0;
    
    [self.signUpView pop_addAnimation:popOutAnimation forKey:@"pop"];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.greyView.alpha = 0.6;
    }];
}

- (IBAction)hideSignIn:(id)sender {
    [self.view endEditing:YES];
    
    POPSpringAnimation *popOutAnimation = [POPSpringAnimation animation];
    popOutAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    
    popOutAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(self.signInView.frame.origin.x, 578, self.signInView.frame.size.width, self.signInView.frame.size.height)];
    popOutAnimation.springBounciness = 10.0;
    popOutAnimation.springSpeed = 10.0;
    
    [self.signInView pop_addAnimation:popOutAnimation forKey:@"pop"];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.greyView.alpha = 0.0;
    }];

}

- (IBAction)hideSignUp:(id)sender {
    [self.view endEditing:YES];
    
    POPSpringAnimation *popOutAnimation = [POPSpringAnimation animation];
    popOutAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    
    popOutAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(self.signInView.frame.origin.x, 578, self.signInView.frame.size.width, self.signInView.frame.size.height)];
    popOutAnimation.springBounciness = 10.0;
    popOutAnimation.springSpeed = 10.0;
    
    [self.signUpView pop_addAnimation:popOutAnimation forKey:@"pop"];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.greyView.alpha = 0.0;
    }];
}

- (IBAction)doSignUp:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)doSignIn:(id)sender {
    [self.view endEditing:YES];
}


#pragma mark - Keyboard

- (void)keyboardDidShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0,-196,320,568)];
    }];
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.1 animations:^{
        [self.view setFrame:CGRectMake(0,0,320,568)];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)dismissKeyboard:(UIGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
}

@end
