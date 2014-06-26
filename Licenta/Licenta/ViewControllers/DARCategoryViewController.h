//
//  DARCategoryViewController.h
//  Foodie
//
//  Created by darius on 26/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DARCategoryViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *categories;
@property (strong, nonatomic) NSMutableArray *categoriesImages;

- (IBAction)backButtonPressed:(id)sender;

@end
