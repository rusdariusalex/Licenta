//
//  DARSelectRestaurantViewController.h
//  Foodie
//
//  Created by darius on 26/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DARSelectRestaurantViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *restaurants;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)backButtonPressed:(id)sender;

@end
