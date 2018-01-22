//
//  UIColor+Extended.m
//  Macros
//
//  Created by Kellen Styler on 9/22/11.
//  Copyright (c) 2011 Mine. All rights reserved.
//

#import "UIColor+Extended.h"

@implementation UIColor ( UIColor_Extended ) 

+ (UIColor * ) UIColorFromRGB:(NSInteger )rgbValue 
    {
        return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                               green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                                blue:((float)(rgbValue & 0xFF))/255.0
                               alpha:1.0];
    }

@end
