//
//  DARAddItemsViewController.m
//  Foodie
//
//  Created by darius on 25/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARAddItemsViewController.h"
#import "DARCategoryViewController.h"
#import "DARTable.h"
#import "UIFont+Additions.h"
#import "DARMenuItem.h"
#import "DARMenuItemTableViewCell.h"
#import "UIColor-Additions.h"
#import <Parse/Parse.h>
#import "DARItemViewController.h"
#import "DARFinishOrderViewController.h"

@interface DARAddItemsViewController (){
    DARTable *table;
    DARMenuItem *menuItemForCell;
}

@end

@implementation DARAddItemsViewController

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
    
    self.titleLabel.text = self.category;
    
    table = [DARTable sharedInstance];
    
    if (![table.restaurantName isEqualToString:@""]) {
        self.restaurantName = table.restaurantName;
    }else{
        self.restaurantName = table.offlineRestaurantName;
    }
    
    self.colors = [NSMutableArray arrayWithArray:[self wheelColors]];
    
    self.menuArray = [[NSMutableArray alloc] init];
    menuItemForCell = [[DARMenuItem alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"MenuItem"];
    [query whereKey:@"restaurant" equalTo:self.restaurantName];
    if (![self.category isEqualToString:@"All"]) {
        [query whereKey:@"type" equalTo:self.category];
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (PFObject *object in objects) {
                DARMenuItem *menuItem = [[DARMenuItem alloc] init];
                
                menuItem = [menuItem menuItemWithName:[object objectForKey:@"name"]
                                          description:[object objectForKey:@"description"]
                                             photoURL:[object objectForKey:@"photoURL"]
                                             calories:[object objectForKey:@"calories"]
                                                price:[object objectForKey:@"price"]];
                [self.menuArray addObject:menuItem];
            }
            
            [self.tableView reloadData];
            [self.activityIndicator setAlpha:0.0];
            
            NSLog(@"%@",self.menuArray);
        }
    }];

    
    [self.activityIndicator startAnimating];
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

- (IBAction)finishOrder:(id)sender {
    DARFinishOrderViewController *finishOrder  =[[DARFinishOrderViewController alloc] init];
    [self.navigationController pushViewController:finishOrder animated:YES];
}


#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MenuItem";
    
    DARMenuItemTableViewCell *cell = (DARMenuItemTableViewCell*)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DARMenuItemTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    menuItemForCell = [self.menuArray objectAtIndex:indexPath.row];
    
    cell.name.text = menuItemForCell.name;
    cell.price.text = [NSString stringWithFormat:@"%@",menuItemForCell.price];
    cell.description = menuItemForCell.description;
    cell.photo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:menuItemForCell.photoURL]]];
    cell.calories = menuItemForCell.calories;
    
    cell.photo.layer.cornerRadius = cell.photo.frame.size.width / 2;
    cell.photo.clipsToBounds = YES;
    cell.photo.layer.borderWidth = 3.0f;
    cell.photo.layer.borderColor = [UIColor whiteColor].CGColor;

    
    cell.name.font = [UIFont openSansSemiBoldWithSize:20];
    cell.price.font = [UIFont openSansSemiBoldWithSize:17];
    
    [cell.contentView setBackgroundColor:[UIColor colorWithHex:[self.colors objectAtIndex:(indexPath.row + self.colors.count) % self.colors.count]]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DARItemViewController *itemView = [[DARItemViewController alloc] init];
    
    menuItemForCell = [self.menuArray objectAtIndex:indexPath.row];
    
    itemView.itemName = menuItemForCell.name;
    itemView.itemPrice = menuItemForCell.price;
    itemView.itemDescription = menuItemForCell.description;
    itemView.itemImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:menuItemForCell.photoURL]]];
    itemView.itemCalories = menuItemForCell.calories;
    itemView.item = menuItemForCell;
    
    
    [self.navigationController pushViewController:itemView animated:YES];
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
