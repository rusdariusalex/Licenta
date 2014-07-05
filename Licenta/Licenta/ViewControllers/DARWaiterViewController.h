//
//  DARWaiterViewController.h
//  Foodie
//
//  Created by darius on 25/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DARWaiterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *orders;

@property (strong,nonatomic) NSMutableArray *colors;

- (IBAction)logOut:(id)sender;

@end
