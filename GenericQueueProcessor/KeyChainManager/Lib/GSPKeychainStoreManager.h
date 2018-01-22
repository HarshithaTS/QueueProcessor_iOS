//
//  GSPKeychainStoreManager.h
//  GssServicePro
//
//  Created by Riyas Hassan on 08/01/15.
//  Copyright (c) 2015 Riyas Hassan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSPKeychainStoreManager : NSObject

+ (void)saveDataInKeyChain:(NSMutableArray*)array;

+ (NSMutableArray*) arrayFromKeychain;

+ (void) deleteItemsFromKeyChain;

+ (void) saveErrorItemsInKeychain:(NSMutableArray*)array;

+ (NSMutableArray*)getErrorItemsFromKeyChain;

// Added by Harshitha
+ (void) deleteErrorItemsFromKeyChain;

@end
