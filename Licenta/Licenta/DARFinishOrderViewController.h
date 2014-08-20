//
//  DARFinishOrderViewController.h
//  Foodie
//
//  Created by darius on 25/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAROrder.h"

@interface DARFinishOrderViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) DAROrder *order;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *addItemsLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderSuccessfulLabel;

@property (strong,nonatomic) NSMutableArray *colors;
@property (weak, nonatomic) IBOutlet UILabel *totalCalories;
@property (weak, nonatomic) IBOutlet UILabel *recomendedCalories;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)finishOrder:(id)sender;

- (float)caloriesFromNumberOfSteps:(NSInteger)numberOfSteps sex:(NSString*)sex height:(NSNumber*)height weight:(NSNumber*)weight age:(NSNumber*)age;

@end
