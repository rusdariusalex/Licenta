//
//  UIColor+UIColor_Additions.h
//  MeeGenius
//
//  Created by Andrei Vig on 7/3/12.
//  Copyright (c) 2012 MeeGenius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColor_Additions)



+ (UIColor *)headerColor;
+ (UIColor *)pinkColor;

+ (UIColor *)primaryUPColor;
+ (UIColor *)primaryDownColor;
+ (UIColor *)secondaryUPColor;
+ (UIColor *)secondaryDownColor;
+ (UIColor *)buyUPColor;
+ (UIColor *)buyDownColor;
+ (UIColor *)suggestUPColor;
+ (UIColor *)suggestDownColor;
+ (UIColor *)disabledColor;

+ (UIColor *)facebookUPColor;
+ (UIColor *)facebookDownColor;

+ (UIColor *)twitterUPColor;
+ (UIColor *)twitterDownColor;

+ (UIColor *)googlePlusUPColor;
+ (UIColor *)googlePlusDownColor;

+ (UIColor *)colorWithHex:(NSString *)hex;

+ (UIColor *)backDownColor;
+ (UIColor *)backUpColor;

+ (NSArray *)wheelColors;

@end
