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
    UIGestureRecognizer *dismissKeyboard;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    dismissKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:dismissKeyboard];

    
    user = [DARUser sharedInstance];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.emailLabel.text = user.email;
    self.emailLabel.font = [UIFont openSansRegularWithSize:20];
    
    if (![user.name isEqualToString:@""]) {
        self.nameField.text = user.name;
    }
    
    if (![user.address isEqualToString:@""]) {
        self.addressField.text = user.address;
    }
    
    if ([user.height intValue] != 0) {
        self.heightField.text = [NSString stringWithFormat:@"%@",user.height];
    }
    
    if ([user.weight intValue] != 0) {
        self.weightField.text = [NSString stringWithFormat:@"%@",user.weight];
    }
    
    if ([user.age intValue] != 0) {
        self.ageField.text = [NSString stringWithFormat:@"%@",user.age];
    }
    
    if (![user.sex isEqualToString:@""]) {
        self.sexField.text = user.sex;
    }
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
    
    [self dismissKeyboard:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)updateInfo:(id)sender {
    
    [self dismissKeyboard:nil];
    
    NSString *name;
    NSString *address;
    NSNumber *height;
    NSNumber *weight;
    NSNumber *age;
    NSString *sex;
    
    if (![self.nameField.text isEqualToString:@""]) {
        name = self.nameField.text;
    }else{
        name = user.name;
    }
    
    if (![self.addressField.text isEqualToString:@""]) {
        address = self.addressField.text;
    }else{
        address = user.address;
    }
    
    if (![self.heightField.text isEqualToString:@""]) {
        NSNumberFormatter * formater = [[NSNumberFormatter alloc] init];
        [formater setNumberStyle:NSNumberFormatterDecimalStyle];
        height = [formater numberFromString:self.heightField.text];
    }else{
        height = user.height;
    }
    
    if (![self.weightField.text isEqualToString:@""]) {
        NSNumberFormatter * formater = [[NSNumberFormatter alloc] init];
        [formater setNumberStyle:NSNumberFormatterDecimalStyle];
        weight = [formater numberFromString:self.weightField.text];
    }else{
        weight = user.weight;
    }
    
    if (![self.ageField.text isEqualToString:@""]) {
        NSNumberFormatter * formater = [[NSNumberFormatter alloc] init];
        [formater setNumberStyle:NSNumberFormatterDecimalStyle];
        age = [formater numberFromString:self.ageField.text];
    }else{
        age = user.age;
    }
    
    if (![self.nameField.text isEqualToString:@""]) {
        if ([self.sexField.text isEqualToString:@"M"] || [self.sexField.text isEqualToString:@"F"]) {
            sex = self.sexField.text;
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sex Field Error!" message:@"You can only enter M or F!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }else{
        sex = user.sex;
    }

    
    [user updateUserName:name address:address height:height weight:weight age:age sex:sex];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0,-196,320,568)];
        self.emailLabel.alpha = 0.0;
    }];
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.1 animations:^{
        [self.view setFrame:CGRectMake(0,0,320,568)];
        self.emailLabel.alpha = 1.0;
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
