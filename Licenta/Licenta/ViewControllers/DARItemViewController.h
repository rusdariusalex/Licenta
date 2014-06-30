//
//  DARItemViewController.h
//  Foodie
//
//  Created by darius on 30/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DARMenuItem.h"
#import "DAROrderItem.h"

@interface DARItemViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemCaloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;
@property (weak, nonatomic) IBOutlet UIView *itemAddedView;


@property (strong, nonatomic) UIImage *itemImage;
@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) NSString *itemDescription;
@property (strong, nonatomic) NSNumber *itemPrice;
@property (strong, nonatomic) NSNumber *itemCalories;
@property (strong, nonatomic) DARMenuItem *item;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)addItem:(id)sender;
- (IBAction)editingChanged:(id)sender;


@end
