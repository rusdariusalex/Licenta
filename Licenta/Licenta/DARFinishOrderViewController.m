//
//  DARFinishOrderViewController.m
//  Foodie
//
//  Created by darius on 25/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import "DARFinishOrderViewController.h"
#import "DARTable.h"
#import "DARUser.h"
#import "DARFinishTableViewCell.h"
#import "DAROrderItem.h"
#import "UIColor-Additions.h"
#import <Parse/Parse.h>

@interface DARFinishOrderViewController (){
    DAROrderItem *orderItem;
}

@end

@implementation DARFinishOrderViewController

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
    
    self.orderSuccessfulLabel.alpha = 0.0;
    
    orderItem = [[DAROrderItem alloc] init];
    
    self.colors = [NSMutableArray arrayWithArray:[self wheelColors]];
    
    self.order = [DAROrder sharedInstance];
    
    DARTable *table = [DARTable sharedInstance];
    DARUser *user = [DARUser sharedInstance];
    
    if ([user.height intValue] !=0 && [user.weight intValue] != 0) {
        self.recomendedCalories.text = [NSString stringWithFormat:@"%.2f", roundf((66.4730 + 13.7516*[user.weight floatValue] + 5.0033*[user.height floatValue] - 6.7550*30))];
    }else{
        self.recomendedCalories.text = @"-";
    }
    
    if ([table.tableNo isEqualToString:@""]) {
        if (![user.address isEqualToString:@""]) {
            self.order.address = user.address;
        }
    }else{
        self.order.address = table.tableNo;
    }
    
    self.order.user = user.email;
    
    [self reloadTotalValue];
    
    [self.tableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.order.items.count == 0) {
        self.addItemsLabel.alpha = 1.0;
    }else{
        self.addItemsLabel.alpha = 0.0;
    }
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
    
    if ([self.order.totalPrice intValue] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Items!" message:@"Please add some Items to order" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else if ([self.order.address isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Address!" message:@"Please go to Account Settings and edit your Address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        PFObject *order = [self.order getPFObjectForOrder];
        
        [order saveInBackground];
        
        [self.order resetOrder];
        [self.tableView reloadData];
        
        
        [UIView animateWithDuration:0.7 animations:^{
            self.orderSuccessfulLabel.alpha = 1.0;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.orderSuccessfulLabel.alpha = 0.0;
            }completion:^(BOOL finished) {
                self.addItemsLabel.alpha = 1.0;
            }];
        }];
    }
}


#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.order.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FinishItem";
    
    DARFinishTableViewCell *cell = (DARFinishTableViewCell*)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DARFinishTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    orderItem = [self.order.items objectAtIndex:indexPath.row];
    
    cell.itemName.text = orderItem.menuItem.name;
    cell.itemPrice.text = [NSString stringWithFormat:@"%d",([orderItem.menuItem.price intValue]*[orderItem.quantity intValue])];
    cell.itemQuantity.text = [NSString stringWithFormat:@"%@",orderItem.quantity];
    
    [cell.contentView setBackgroundColor:[UIColor colorWithHex:[self.colors objectAtIndex:(indexPath.row + self.colors.count) % self.colors.count]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    [self.order.items removeObjectAtIndex:indexPath.row];
    
    // Request table view to reload
    [self reloadTotalValue];
    [tableView reloadData];
}

- (void)reloadTotalValue{
    
    [self.order totalPriceCalculate];
    
    if (self.order.items.count == 0) {
        self.addItemsLabel.alpha = 1.0;
    }else{
        self.addItemsLabel.alpha = 0.0;
    }
    
    self.totalLabel.text = [NSString stringWithFormat:@"%@",self.order.totalPrice];
    self.totalCalories.text = [NSString stringWithFormat:@"%@",self.order.totalCalories];
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
