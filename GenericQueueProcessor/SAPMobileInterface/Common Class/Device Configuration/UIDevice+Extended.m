//
//  UIDevice+Extended.m
//  Macros
//
//  Created by Kellen Styler on 9/22/11.
//  Copyright (c) 2011 Mine. All rights reserved.
//

#import "UIDevice+Extended.h"

#define IPHONE_SIM      @"i386"         //480×320 res
#define IPHONE_BASE     @"iPhone1,1"	//480×320 res
#define IPHONE_3G       @"iPhone1,2"	//480×320 res
#define IPHONE_3GS      @"iPhone2,1"	//480×320 res
#define IPHONE_4G       @"iPhone3,1"	//960×640 res (retina display)
#define IPOD_GEN1       @"iPod1,1"      //480×320 res
#define IPOD_GEN2       @"iPod2,1"      //480×320 res
#define IPOD_GEN3       @"iPod3,1"      //480×320 res
#define IPOD_GEN4       @"iPod4,1"      //960×640 res (retina display)
#define IPAD1           @"iPad1,1"      //1024×768 res (hd)
#define IPAD2           @"iPad2,1"      //1024×768 res (hd)
#define IPAD2_GSM       @"iPad2,2"      //1024×768 res (hd)
#define IPAD2_CDMA      @"iPad2,3"      //1024×768 res (hd)

@implementation UIDevice ( UIDevice_Extended ) 

- (NSString * ) deviceType
    {
        size_t size; 
        sysctlbyname( "hw.machine" , NULL , &size , NULL , 0 ); 
        char *name = malloc( size );
        sysctlbyname( "hw.machine" , name , &size , NULL , 0 );
        NSString * deviceTypeIdentifier = [NSString stringWithCString:name encoding:NSUTF8StringEncoding ];
        free( name );
        return deviceTypeIdentifier;
    } 

@end
