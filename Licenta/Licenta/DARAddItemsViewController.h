//
//  DARAddItemsViewController.h
//  Foodie
//
//  Created by darius on 25/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DARAddItemsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *restaurantName;
@property (strong, nonatomic) NSMutableArray *menuArray;

@property (strong,nonatomic) NSMutableArray *colors;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)finishOrder:(id)sender;


@end
