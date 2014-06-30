//
//  DARItemViewController.m
//  Foodie
//
//  Created by darius on 30/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARItemViewController.h"
#import "UIFont+Additions.h"

@interface DARItemViewController (){
    
}

@end

@implementation DARItemViewController{
    UIGestureRecognizer *dismissKeyboard;
}

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
    
    self.itemAddedView.alpha = 0.0;
    self.itemAddedView.layer.masksToBounds = YES;
    self.itemAddedView.layer.cornerRadius = 20;
    
    self.itemNameLabel.text = self.itemName;
    self.itemNameLabel.font = [UIFont openSansSemiBoldWithSize:60];
    
    self.itemImageLabel.image = self.itemImage;
    
    self.itemDescriptionLabel.text = self.itemDescription;
    self.itemNameLabel.font = [UIFont openSansSemiBoldWithSize:25];
    
    self.itemPriceLabel.text = [NSString stringWithFormat:@"%@",self.itemPrice];
    self.itemPriceLabel.font = [UIFont openSansSemiBoldWithSize:17];
    
    self.itemCaloriesLabel.text = [NSString stringWithFormat:@"%@",self.itemCalories];
    self.itemCaloriesLabel.font = [UIFont openSansSemiBoldWithSize:17];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    float index = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-1] animated:YES];
}

- (IBAction)addItem:(id)sender {
    [self dismissKeyboard:nil];
    
    if ([self.quantityTextField.text intValue] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter a valid quantity!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        DAROrderItem *orderItem = [[DAROrderItem alloc] init];
        
        orderItem.menuItem = self.item;
        orderItem.quantity = [NSNumber numberWithInt:[self.quantityTextField.text intValue]];
        
        [orderItem addItem];
        
        [UIView animateWithDuration:0.7 animations:^{
            self.itemAddedView.alpha = 1.0;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.itemAddedView.alpha = 0.0;
            }completion:^(BOOL finished) {
                
            }];
        }];
    }
}

- (IBAction)editingChanged:(id)sender {
    
    int calories;
    int price;
    
    if ([self.quantityTextField.text intValue] != 0) {
        calories = [self.itemCalories intValue];
        price = [self.itemPrice intValue];
        
        self.itemCaloriesLabel.text = [NSString stringWithFormat:@"%d", (calories*[self.quantityTextField.text intValue])];
        self.itemPriceLabel.text = [NSString stringWithFormat:@"%d", (price*[self.quantityTextField.text intValue])];
    }else{
        calories = [self.itemCalories intValue];
        price = [self.itemPrice intValue];
        
        self.itemCaloriesLabel.text = [NSString stringWithFormat:@"%d", calories];
        self.itemPriceLabel.text = [NSString stringWithFormat:@"%d", price];
    }
    
}

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
