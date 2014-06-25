//
//  UIFont+Additions.m
//  MeeGenius
//
//  Created by ANDREI VIG on 7/3/13.
//
//

#import "UIFont+Additions.h"

@implementation UIFont (Additions)

+ (UIFont *)openSansSemiBoldWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"OpenSans-Semibold" size:size];
}

+ (UIFont *)openSansRegularWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Open Sans" size:size];
}

+ (UIFont *)openSansLightWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"OpenSans-Light" size:size];
}
@end
