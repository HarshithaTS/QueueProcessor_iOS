//
//  UIDevice+Extended.h
//  Macros
//
//  Created by Kellen Styler on 9/22/11.
//  Copyright (c) 2011 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/types.h>
#import <sys/sysctl.h>

@interface UIDevice ( UIDevice_Extended ) 

- (NSString *)deviceType;

@end
