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
#import <CoreMotion/CoreMotion.h>

@interface DARFinishOrderViewController (){
    DAROrderItem *orderItem;
    CMStepCounter *stepCounter;
    NSOperationQueue *stepQueue;
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
    
    stepCounter = [[CMStepCounter alloc] init];
    stepQueue = [[NSOperationQueue alloc] init];
    stepQueue.maxConcurrentOperationCount = 7;
    
    NSDate *now = [NSDate date];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[[NSDate alloc] init]];
    
    [components setDay:([components day] - 6)];
    NSDate *lastWeek  = [cal dateFromComponents:components];
    
    [stepCounter queryStepCountStartingFrom:lastWeek
                                          to:now
                                     toQueue:stepQueue
                                 withHandler:^(NSInteger numberOfSteps,
                                               NSError *error) {
                                     if (error)
                                     {
                                         
                                     }
                                     else
                                     {
                                         
                                         

                                         if ([user.height intValue] !=0 && [user.weight intValue] != 0 && [user.age intValue] != 0 && ![user.sex isEqualToString:@""]) {
                                             
                                             float recommended = [self caloriesFromNumberOfSteps:numberOfSteps sex:user.sex height:user.height weight:user.weight age:user.age];
                                             
                                             self.recomendedCalories.text = [NSString stringWithFormat:@"%.2f", recommended];
                                             
                                             
                                         }else{
                                             self.recomendedCalories.text = @"-";
                                         }

                                     }
                                 }];
    
    
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

- (float)caloriesFromNumberOfSteps:(NSInteger)numberOfSteps sex:(NSString*)sex height:(NSNumber*)height weight:(NSNumber*)weight age:(NSNumber*)age{
    float harrisConstant;
    
    if (numberOfSteps/7 <= 5000) {
        harrisConstant = 1.2;
    }else if (numberOfSteps/7 > 5000 && numberOfSteps/7 <= 7500){
        harrisConstant = 1.375;
    }else if (numberOfSteps/7 > 7500 && numberOfSteps/7 <= 10000){
        harrisConstant = 1.55;
    }else if (numberOfSteps/7 > 10000 && numberOfSteps/7 <= 12500){
        harrisConstant = 1.725;
    }else{
        harrisConstant = 1.9;
    }
    
    float recomended;
    
    if ([sex isEqualToString:@"M"]) {
        recomended = harrisConstant*(88.362 + (13.397*[weight floatValue]) + (4.799*[height floatValue]) - (5.677*[age floatValue]));
    }else if ([sex isEqualToString:@"F"]){
        recomended = harrisConstant*(447.593 + (9.247*[weight floatValue]) + (3.098*[height floatValue]) - (4.330*[age floatValue]));
    }
    
    return recomended;
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
                
                self.totalCalories.text = @"0";
                self.totalLabel.text = @"0";
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
