//
//  DARWaiterDetailViewController.h
//  Foodie
//
//  Created by darius on 05/07/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAROrderForWaiter.h"

@interface DARWaiterDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *assignedLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *colors;

@property (strong, nonatomic) DAROrderForWaiter *order;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)assignButtonPressed:(id)sender;
- (IBAction)serveButtonPressed:(id)sender;
- (IBAction)paymentButtonPressed:(id)sender;


@end
