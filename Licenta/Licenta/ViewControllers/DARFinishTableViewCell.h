//
//  DARFinishTableViewCell.h
//  Foodie
//
//  Created by darius on 30/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DARFinishTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemQuantity;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;

@end
