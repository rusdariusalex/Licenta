//
//  DARLogInViewController.m
//  Foodie
//
//  Created by darius on 02/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARLogInViewController.h"
#import "POP.h"
#import <Parse/Parse.h>
#import "DARUser.h"
#import "DARMainViewController.h"
#import "DARWaiterViewController.h"



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
    
    self.navigationController.navigationBarHidden = YES;
    
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
    
    self.signInAlertLabel.text = @"";
    self.signInAlertLabel.alpha = 0.0;
    self.signUpAlertLabel.text = @"";
    self.signUpAlertLabel.alpha = 0.0;
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
    
    self.signUpAlertLabel.text = @"";
    self.signUpAlertLabel.alpha = 0.0;
    self.signInAlertLabel.text = @"";
    self.signInAlertLabel.alpha = 0.0;
}

- (IBAction)doSignUp:(id)sender {
    [self.view endEditing:YES];
    
    if ([self.signUpNameTextField.text isEqualToString:@""] || [self.signUpEmailTextField.text isEqualToString:@""] || [self.signUpPasswordTextField.text isEqualToString:@""]) {
        self.signUpAlertLabel.text = @"Please complete all fields!";
        self.signUpAlertLabel.alpha = 1.0;
    }else{
        if ([self NSStringIsValidEmail:self.signUpEmailTextField.text]) {
            PFQuery *query = [PFQuery queryWithClassName:@"User"];
            [query whereKey:@"email" equalTo:self.signUpEmailTextField.text];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    if (!objects.count) {
                        DARUser *user = [DARUser sharedInstance];
                        [user addUser:self.signUpNameTextField.text
                                email:self.signUpEmailTextField.text
                             password:self.signUpPasswordTextField.text
                              address:@"" role:@"user" height:[NSNumber numberWithInt:0]
                               weight:[NSNumber numberWithInt:0]];
                        
                        [user setUser:self.signUpNameTextField.text
                                email:self.signUpEmailTextField.text
                             password:self.signUpPasswordTextField.text
                              address:@""
                                 role:@"user"
                               height:[NSNumber numberWithInt:0]
                               weight:[NSNumber numberWithInt:0]];
                        
                        self.greyView.alpha = 0.0;
                        self.showSignInButton.alpha = 0.0;
                        self.showSignUpButton.alpha = 0.0;
                        
                        DARMainViewController *mainViewController  =[[DARMainViewController alloc] init];
                        
                        [self.navigationController pushViewController:mainViewController animated:YES];
                    }else{
                        self.signUpAlertLabel.text = @"An user with this email already exists";
                        self.signUpAlertLabel.alpha = 1.0;
                    }
                    
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }else{
            self.signUpAlertLabel.text = @"Please enter valid email address!";
            self.signUpAlertLabel.alpha = 1.0;
        }

    }
}

- (IBAction)doSignIn:(id)sender {
    [self.view endEditing:YES];
    
    if ([self.signInEmailTextField.text isEqualToString:@""] || [self.signInPasswordTextField.text isEqualToString:@""]) {
        self.signInAlertLabel.text = @"Please complete all fields!";
        self.signInAlertLabel.alpha = 1.0;
    }else{
        if ([self NSStringIsValidEmail:self.signInEmailTextField.text]) {
            PFQuery *query = [PFQuery queryWithClassName:@"User"];
            [query whereKey:@"email" equalTo:self.signInEmailTextField.text];
            [query whereKey:@"password" equalTo:self.signInPasswordTextField.text];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    
                    if (objects.count) {
                        PFObject *object = [objects firstObject];
                        
                        if ([[object objectForKey:@"role"] isEqualToString:@"user"]) {
                            DARUser *user = [DARUser sharedInstance];
                            [user setUser:[object objectForKey:@"name"]
                                    email:[object objectForKey:@"email"]
                                 password:[object objectForKey:@"password"]
                                  address:[object objectForKey:@"address"]
                                     role:[object objectForKey:@"role"]
                                   height:[object objectForKey:@"height"]
                                   weight:[object objectForKey:@"weight"]];
                            
                            self.greyView.alpha = 0.0;
                            self.showSignInButton.alpha = 0.0;
                            self.showSignUpButton.alpha = 0.0;
                            
                            
                            DARMainViewController *mainViewController  =[[DARMainViewController alloc] init];
                            
                            [self.navigationController pushViewController:mainViewController animated:YES];
                        }else if ([[object objectForKey:@"role"] isEqualToString:@"waiter"]){
                            DARUser *user = [DARUser sharedInstance];
                            [user setUser:[object objectForKey:@"name"]
                                    email:[object objectForKey:@"email"]
                                 password:[object objectForKey:@"password"]
                                  address:[object objectForKey:@"address"]
                                     role:[object objectForKey:@"role"]
                                   height:[object objectForKey:@"height"]
                                   weight:[object objectForKey:@"weight"]];
                            
                            self.greyView.alpha = 0.0;
                            self.showSignInButton.alpha = 0.0;
                            self.showSignUpButton.alpha = 0.0;
                            
                            DARMainViewController *mainViewController  =[[DARMainViewController alloc] init];
                            
                            [self.navigationController pushViewController:mainViewController animated:YES];
                        }
                        
                        
                    }else{
                        self.signInAlertLabel.text = @"Wrong email or password!";
                        self.signInAlertLabel.alpha = 1.0;
                    }
                    
                    for (PFObject *object in objects) {
                        NSLog(@"%@", object.objectId);
                    }
                    
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }else{
            self.signInAlertLabel.text = @"Please enter valid email address!";
            self.signInAlertLabel.alpha = 1.0;
        }
    }
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
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

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.signUpAlertLabel.text = @"";
    self.signUpAlertLabel.alpha = 0.0;
    self.signInAlertLabel.text = @"";
    self.signInAlertLabel.alpha = 0.0;
}

- (void)dismissKeyboard:(UIGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
}

@end
