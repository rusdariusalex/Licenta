//
//  UIColor+UIColor_Additions.m
//  MeeGenius
//
//  Created by Andrei Vig on 7/3/12.
//  Copyright (c) 2012 MeeGenius. All rights reserved.
//

#import "UIColor-Additions.h"

@implementation UIColor (UIColor_Additions)

+ (UIColor *)headerColor {
    return [UIColor colorWithRed:0.275 
                           green:0.773 
                            blue:0.941 
                           alpha:1.0];
}

+ (UIColor *)pinkColor {
    return [UIColor colorWithRed:0.929 green:0.118 blue:0.475 alpha:1.0];
}

// new button colors
+ (UIColor *)primaryUPColor {
    return [UIColor colorWithRed:0.84 green:0.30 blue:0.42 alpha:1.0];
}

+ (UIColor *)primaryDownColor {
    return [UIColor colorWithRed:0.85 green:0.19 blue:0.32 alpha:1.0];
}

+ (UIColor *)backDownColor {
    return [UIColor colorWithRed:125.0/255.0 green:42.0/255.0 blue:123.0/255.0 alpha:1.0];
}

+ (UIColor *)backUpColor {
    return [UIColor colorWithRed:92.0/255.0 green:42.0/255.0 blue:123.0/255.0 alpha:1.0];
}

+ (UIColor *)secondaryUPColor {
    return [UIColor colorWithRed:0.16 green:0.67 blue:0.88 alpha:1.0];
}

+ (UIColor *)secondaryDownColor {
    return [UIColor colorWithRed:0.06 green:0.44 blue:0.73 alpha:1.0];
}

+ (UIColor *)buyUPColor {
    return [UIColor colorWithRed:0.38 green:0.73 blue:0.27 alpha:1.0];
}

+ (UIColor *)buyDownColor {
    return [UIColor colorWithRed:0.25 green:0.56 blue:0.25 alpha:1.0];
}

+ (UIColor *)suggestUPColor {
    return [UIColor colorWithRed:0.49 green:0.24 blue:0.59 alpha:1.0];
}

+ (UIColor *)suggestDownColor {
    return [UIColor colorWithRed:0.36 green:0.16 blue:0.48 alpha:1.0];
}

+ (UIColor *)disabledColor {
    return [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
}

+ (UIColor *)facebookUPColor {
    return [UIColor colorWithRed:0.26 green:0.36 blue:0.55 alpha:1.0];
}
+ (UIColor *)facebookDownColor {
    return [UIColor colorWithRed:0.26 green:0.36 blue:0.55 alpha:1.0];
}

+ (UIColor *)twitterUPColor {
    return [UIColor colorWithRed:0.0 green:0.67 blue:0.94 alpha:1.0];
}
+ (UIColor *)twitterDownColor {
    return [UIColor colorWithRed:0.0 green:0.67 blue:0.94 alpha:1.0];
}

+ (UIColor *)googlePlusUPColor {
    return [UIColor colorWithRed:0.83 green:0.28 blue:0.21 alpha:1.0];
}
+ (UIColor *)googlePlusDownColor {
    return [UIColor colorWithRed:0.83 green:0.28 blue:0.21 alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSString *)hex {
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (NSArray *)wheelColors {
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
