//
//  DARWaiterTableViewCell.h
//  Foodie
//
//  Created by darius on 05/07/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DARWaiterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


@end
