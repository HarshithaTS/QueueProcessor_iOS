//
//  iOSMacros.h
//  Macros
//
//  Created by Kellen Styler on 9/20/11.
//  Copyright (c) 2011 Mine. All rights reserved.


#ifndef Macros_iOSMacros_h
#define Macros_iOSMacros_h

#import "UIDevice+Extended.h"
#import "UIColor+Extended.h"

// 
//  Device Info
//

/** String: Identifier **/
#define DEVICE_IDENTIFIER ( ( IS_IPAD ) ? DEVICE_IPAD : ( IS_IPHONE ) ? DEVICE_IPHONE , DEVICE_SIMULATOR )
 
/** String: iPhone **/
#define DEVICE_IPHONE @"iPhone"

/** String: iPad **/
#define DEVICE_IPAD @"iPad"

/** String: Device Model **/
#define DEVICE_MODEL ( [[UIDevice currentDevice ] model ] )

/** String: Localized Device Model **/
#define DEVICE_MODEL_LOCALIZED ( [[UIDevice currentDevice ] localizedModel ] )

/** String: Device Name **/
#define DEVICE_NAME ( [[UIDevice currentDevice ] name ] )

/** Double: Device Orientation **/
#define DEVICE_ORIENTATION ( [[UIDevice currentDevice ] orientation ] )

/** String: Simulator **/
#define DEVICE_SIMULATOR @"Simulator"

/** String: Device Type **/
#define DEVICE_TYPE ( [[UIDevice currentDevice ] deviceType ] )

/** BOOL: Detect if device is an iPad **/
#define IS_IPAD ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )

/** BOOL: Detect if device is an iPhone or iPod **/
#define IS_IPHONE ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )

/** BOOL: IS_RETINA **/
#define IS_RETINA ( [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2 )

/** BOOL: Detect if device is the Simulator **/
#define IS_SIMULATOR ( TARGET_IPHONE_SIMULATOR ) 



//
//  System Info
//

/** String: System Name **/  
#define SYSTEM_NAME ( [[UIDevice currentDevice ] systemName ] )

/** String: System Version **/
#define SYSTEM_VERSION ( [[UIDevice currentDevice ] systemVersion ] )



//
//  Screen Info
//
 
/** Float: Portrait Screen Height **/
#define SCREEN_HEIGHT_PORTRAIT ( [[UIScreen mainScreen ] bounds ].size.height )

/** Float: Portrait Screen Width **/
#define SCREEN_WIDTH_PORTRAIT ( [[UIScreen mainScreen ] bounds ].size.width )

/** Float: Landscape Screen Height **/
#define SCREEN_HEIGHT_LANDSCAPE ( [[UIScreen mainScreen ] bounds ].size.width )  

/** Float: Landscape Screen Width **/
#define SCREEN_WIDTH_LANDSCAPE ( [[UIScreen mainScreen ] bounds ].size.height )

/** CGRect: Portrait Screen Frame **/
#define SCREEN_FRAME_PORTRAIT ( CGRectMake( 0, 0, SCREEN_WIDTH_PORTRAIT , SCREEN_HEIGHT_PORTRAIT ) )

/** CGRect: Landscape Screen Frame **/
#define SCREEN_FRAME_LANDSCAPE ( CGRectMake( 0, 0, SCREEN_WIDTH_LANDSCAPE , SCREEN_HEIGHT_LANDSCAPE ) )

/** Float: Screen Scale **/ 
#define SCREEN_SCALE ([[UIScreen mainScreen] scale ] )

/** CGSize: Screen Size Portrait **/
#define SCREEN_SIZE_PORTRIAT ( CGSizeMake( SCREEN_WIDTH_PORTRAIT * SCREEN_SCALE , SCREEN_HEIGHT_PORTRAIT * SCREEN_SCALE ) )

/** CGSize: Screen Size Landscape **/
#define SCREEN_SIZE_LANDSCAPE ( CGSizeMake( SCREEN_WIDTH_LANDSCAPE * SCREEN_SCALE , SCREEN_HEIGHT_LANDSCAPE * SCREEN_SCALE ) )




//
//  Colors
//

/** UIColor: Color From Hex **/
#define colorFromHex( rgbValue ) ( [UIColor UIColorFromRGB:rgbValue ] )

/** UIColor: Color from RGB **/
#define colorFromRGB( r , g , b ) ( [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1 ] )

/** UIColor: Color from RGBA **/
#define colorFromRGBA(r , g , b , a ) ( [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a ] )



//
//  Degrees and Radians 
//

/** Float: Degrees -> Radian **/
#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )

/** Float: Radians -> Degrees **/
#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )


#endif
