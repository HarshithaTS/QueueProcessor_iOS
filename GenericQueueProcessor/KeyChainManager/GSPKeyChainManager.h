//
//  GSPKeyChainManager.h
//  GssServicePro
//
//  Created by Riyas Hassan on 20/08/14.
//  Copyright (c) 2014 Riyas Hassan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSPKeyChainManager : NSObject

{

}

- (void)saveServiceTaskInKeyChain:(NSDictionary*)object forApplicationIdentifier:(NSString*)identifier;

- (void) deleteServiceTaskFromKeyChain:(id)object forIdentifier:(NSString*)identifier;

- (NSData *)searchKeychainCopyMatching:(NSString *)identifier ;

- (void)saveCompletedServiceTaskInKeyChain:(NSDictionary*)object;

- (BOOL)updateKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier;

@end
