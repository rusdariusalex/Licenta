//
//  DARMenuItemTableViewCell.h
//  Foodie
//
//  Created by darius on 27/06/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DARMenuItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSNumber *calories;
@property (weak, nonatomic) IBOutlet UILabel *price;


@end
