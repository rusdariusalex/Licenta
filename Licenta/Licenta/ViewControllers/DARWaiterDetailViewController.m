//
//  DARWaiterDetailViewController.m
//  Foodie
//
//  Created by darius on 05/07/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARWaiterDetailViewController.h"
#import "DARWaiterOrderTableViewCell.h"
#import "UIColor-Additions.h"
#import "UIFont+Additions.h"
#import <Parse/Parse.h>
#import "DARUser.h"

@interface DARWaiterDetailViewController ()

@end

@implementation DARWaiterDetailViewController

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
    
    self.colors = [NSMutableArray arrayWithArray:[self wheelColors]];
    
    [self refreshView];
}

-  (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self refreshView];
}

- (void)refreshView{
    self.orderNoLabel.text = self.order.orderId;
    
    self.orderNoLabel.font = [UIFont openSansSemiBoldWithSize:25];
    
    self.userLabel.text = self.order.user;
    self.addressLabel.text = self.order.address;
    self.restaurantLabel.text = self.order.restaurant;
    self.totalLabel.text = [NSString stringWithFormat:@"%@",self.order.total];
    self.statusLabel.text = self.order.status;
    
    self.totalLabel.font = [UIFont openSansSemiBoldWithSize:25];
    
    if (![self.order.userAssigned isEqualToString:@""]) {
        self.assignedLabel.text = self.order.userAssigned;
    }else{
        self.assignedLabel.text = @"-";
    }
    
    [self.tableView reloadData];
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

- (IBAction)assignButtonPressed:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Order"];
    [query whereKey:@"objectId" equalTo:self.order.orderId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            PFObject *object = [objects firstObject];
            
            if ([self.order.userAssigned isEqualToString:@""]) {
                self.order.userAssigned = [DARUser sharedInstance].email;
                object[@"userAssigned"] = self.order.userAssigned;
            }else{
                self.order.userAssigned = @"";
                object[@"userAssigned"] = self.order.userAssigned;

            }
            
            if ([self.order.status isEqualToString:@"waiting"]) {
                self.order.status = @"assigned";
                object[@"userAssigned"] = self.order.status;
            }else{
                self.order.status = @"waiting";
                object[@"userAssigned"] = self.order.status;
            }
            
            [self refreshView];
            
            [object saveInBackground];
        }
    }];
}

- (IBAction)serveButtonPressed:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Order"];
    [query whereKey:@"objectId" equalTo:self.order.orderId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            PFObject *object = [objects firstObject];
            
            if ([self.order.userAssigned isEqualToString:@""]) {
                self.order.userAssigned = [DARUser sharedInstance].email;
                object[@"userAssigned"] = self.order.userAssigned;
            }
            
            if ([self.order.status isEqualToString:@"assigned"] || [self.order.status isEqualToString:@"waiting"]){
                self.order.status = @"served";
                object[@"userAssigned"] = self.order.status;
            }else{
                self.order.status = @"assigned";
                object[@"userAssigned"] = self.order.status;
            }
            
            [self refreshView];
            
            [object saveInBackground];
        }
    }];

}

- (IBAction)paymentButtonPressed:(id)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Order"];
    [query whereKey:@"objectId" equalTo:self.order.orderId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            PFObject *object = [objects firstObject];
            
            if ([self.order.userAssigned isEqualToString:@""]) {
                self.order.userAssigned = [DARUser sharedInstance].email;
                object[@"userAssigned"] = self.order.userAssigned;
            }
            
            if ([self.order.status isEqualToString:@"assigned"] || [self.order.status isEqualToString:@"waiting"] || [self.order.status isEqualToString:@"served"]) {
                self.order.status = @"finished";
                object[@"userAssigned"] = self.order.status;
            }else{
                self.order.status = @"assigned";
                object[@"userAssigned"] = self.order.status;
            }
            
            [self refreshView];
            
            [object saveInBackground];
        }
    }];
}

#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.order.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"WaiterOrderCell";
    
    DARWaiterOrderTableViewCell *cell = (DARWaiterOrderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DARWaiterOrderTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.itemNameLabel.text = [[self.order.items objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.itemNameLabel.font = [UIFont openSansSemiBoldWithSize:20];
    
    cell.quantityLabel.text = [NSString stringWithFormat:@"%@", [[self.order.items objectAtIndex:indexPath.row] objectForKey:@"quantity"]];
    cell.totalLabel.text = [NSString stringWithFormat:@"%@", [[self.order.items objectAtIndex:indexPath.row] objectForKey:@"price"]];

    [cell.contentView setBackgroundColor:[UIColor colorWithHex:[self.colors objectAtIndex:(indexPath.row + self.colors.count) % self.colors.count]]];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSArray *)wheelColors {
    // loading hex colors
    NSString *colorsPath = [[NSBundle mainBundle] pathForResource:@"ColorShelfValues" ofType:@"plist"];
    NSArray *colors = [NSArray arrayWithContentsOfFile:colorsPath];
    
    int startColorIndex = arc4random() % [colors count];
    NSMutableArray *newColors = [@[] mutableCopy];
    
    for (int i = startColorIndex; i < [colors count] + startColorIndex; i++) {
        [newColors addObject:[colors objectAtIndex:(i % [colors count])]];
    }
    
    return newColors;
}

@end
