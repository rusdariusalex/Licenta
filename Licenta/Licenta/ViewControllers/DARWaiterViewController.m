//
//  DARWaiterViewController.m
//  Foodie
//
//  Created by darius on 25/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARWaiterViewController.h"
#import "DARUser.h"
#import <Parse/Parse.h>
#import "DAROrderForWaiter.h"
#import "DARWaiterTableViewCell.h"
#import "UIColor-Additions.h"

@interface DARWaiterViewController ()

@end

@implementation DARWaiterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.orders = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.colors = [NSMutableArray arrayWithArray:[self wheelColors]];

    DARUser *user = [DARUser sharedInstance];
    
    self.userLabel.text = user.email;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Order"];
//    [query whereKey:@"restaurant" containsString:user.restaurant];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                DAROrderForWaiter *order = [[DAROrderForWaiter alloc] init];
                
                order.orderId = object.objectId;
                order.user = object[@"user"];
                order.address = object[@"address"];
                order.items = object[@"items"];
                order.userAssigned = object[@"userAssigned"];
                order.total = object[@"total"];
                order.status = object[@"status"];
                order.restaurant = object[@"restaurant"];

                [self.orders addObject:order];
            }
        }
        
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)logOut:(id)sender {
    float index = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-1] animated:YES];
}


#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.orders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"WaiterCell";
    
    DARWaiterTableViewCell *cell = (DARWaiterTableViewCell*)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DARWaiterTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    DAROrderForWaiter *order = [[DAROrderForWaiter alloc] init];
    order = [self.orders objectAtIndex:indexPath.row];
    
    cell.orderIdLabel.text = order.orderId;
    cell.totalLabel.text = [NSString stringWithFormat:@"%@",order.total];
    cell.statusLabel.text = order.status;
    
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
