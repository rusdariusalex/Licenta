//
//  DARLogInViewController.m
//  Foodie
//
//  Created by darius on 02/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARLogInViewController.h"
#import "POP.h"


@interface DARLogInViewController ()

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
    
    POPSpringAnimation *popOutAnimation = [POPSpringAnimation animation];
    popOutAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    
    popOutAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(self.signInView.frame.origin.x, 218, self.signInView.frame.size.width, self.signInView.frame.size.height)];
    popOutAnimation.springBounciness = 10.0;
    popOutAnimation.springSpeed = 10.0;
    
    [self.signInView pop_addAnimation:popOutAnimation forKey:@"pop"];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.greyView.alpha = 0.5;
    }];
}

- (IBAction)showSignUp:(id)sender {
    POPSpringAnimation *popOutAnimation = [POPSpringAnimation animation];
    popOutAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    
    popOutAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(self.signInView.frame.origin.x, 218, self.signInView.frame.size.width, self.signInView.frame.size.height)];
    popOutAnimation.springBounciness = 10.0;
    popOutAnimation.springSpeed = 10.0;
    
    [self.signUpView pop_addAnimation:popOutAnimation forKey:@"pop"];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.greyView.alpha = 0.5;
    }];
}

- (IBAction)hideSignIn:(id)sender {
    
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


@end
