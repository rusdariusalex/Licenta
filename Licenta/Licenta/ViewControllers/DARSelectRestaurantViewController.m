//
//  DARSelectRestaurantViewController.m
//  Foodie
//
//  Created by darius on 26/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARSelectRestaurantViewController.h"
#import "DARMainViewController.h"
#import <Parse/Parse.h>
#import "DARTable.h"
#import "DARCategoryViewController.h"
#import "UIFont+Additions.h"

@interface DARSelectRestaurantViewController ()

@end

@implementation DARSelectRestaurantViewController

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
    self.restaurants = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.activityIndicator startAnimating];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Table"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (PFObject *object in objects) {
                if (![self.restaurants containsObject:[object objectForKey:@"restaurantName"]]) {
                    [self.restaurants addObject:[object objectForKey:@"restaurantName"]];
                }
            }
            
            [self.tableView reloadData];
            [self.activityIndicator setAlpha:0.0];
        }
    }];
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

#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.restaurants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.restaurants objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont openSansSemiBoldWithSize:20];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(172/255.0) blue:(237/255.0) alpha:1.0];
    }else{
       cell.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(132/255.0) blue:(180/255.0) alpha:1.0];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DARTable *table = [DARTable sharedInstance];
    
    table.offlineRestaurantName = [self.restaurants objectAtIndex:indexPath.row];
    
    DARCategoryViewController *categoryView = [[DARCategoryViewController alloc] init];
    [self.navigationController pushViewController:categoryView animated:YES];
}

@end
