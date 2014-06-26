//
//  DARCategoryViewController.m
//  Foodie
//
//  Created by darius on 26/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARCategoryViewController.h"
#import "DARMainViewController.h"
#import "UIFont+Additions.h"
#import "DARMainViewController.h"

@interface DARCategoryViewController ()

@end

@implementation DARCategoryViewController

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
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.categories = [[NSMutableArray alloc] initWithArray:@[@"All",@"Pizza",@"Pasta",@"Salads",@"Soups",@"Meat",@"Desserts",@"Drinks"]];
    
    self.categoriesImages = [[NSMutableArray alloc] initWithArray:@[@"all.png",@"pizza.png",@"pasta.png",@"salad.png",@"soup.png",@"meat.png",@"dessert.png",@"drink.png"]];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor clearColor];
    
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

#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:[self.categoriesImages objectAtIndex:indexPath.row]];    
    
    cell.textLabel.text = [self.categories objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont openSansRegularWithSize:20];
    
    cell.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(172/255.0) blue:(237/255.0) alpha:1.0];
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
