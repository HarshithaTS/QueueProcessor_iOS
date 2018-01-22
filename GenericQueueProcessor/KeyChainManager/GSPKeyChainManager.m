//
//  GSPKeyChainManager.m
//  GssServicePro
//
//  Created by Riyas Hassan on 20/08/14.
//  Copyright (c) 2014 Riyas Hassan. All rights reserved.
//

#import "GSPKeyChainManager.h"
#import <Security/Security.h>
#import "Constants.h"

static NSString *serviceName = @"com.mycompany.gssServicePro";

@implementation GSPKeyChainManager

- (void)saveServiceTaskInKeyChain:(NSDictionary*)object forApplicationIdentifier:(NSString*)identifier
{
    [self writeTaskToKeychain:object andIdentifier:identifier];
    
}

//Saves succesfully complted service tasks in keychain
- (void)saveCompletedServiceTaskInKeyChain:(NSDictionary*)object
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MobileSetup" ofType:@"plist"];
    NSMutableDictionary * MobileSetupDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    
    [object setValue: [MobileSetupDictionary objectForKey:@"PackageName"] forKey:@"packageName"];
    [object setValue: @"COMPLETED" forKey:@"periority"];
    [self writeTaskToKeychain:object andIdentifier:keyChainIdentifierForCompletedTasks];
}

- (void) writeTaskToKeychain:(NSDictionary*)object andIdentifier:(NSString*)identifier
{
    NSData *taskData = [self searchKeychainCopyMatching:identifier];
    
    NSMutableArray *taskArray;
    
    if (taskData)
    {
        taskArray   = [NSJSONSerialization JSONObjectWithData:taskData options:NSJSONReadingMutableContainers error:nil];
    }
    
    if (taskArray == nil)
    {
        taskArray = [NSMutableArray new];
        [self createKeychainValue:@"" forIdentifier:identifier];
    }
    
    for (int i =0; i< taskArray.count; i++)
    {
        NSMutableDictionary * taskDic = [taskArray objectAtIndex:i];
        
        if ([[taskDic valueForKey:@"referenceid"] isEqualToString:[object valueForKey:@"referenceid"]] && [[taskDic valueForKey:@"applicationname"] isEqualToString:[object valueForKey:@"applicationname"]] && [[taskDic valueForKey:@"ID"] isEqualToString:[object valueForKey:@"ID"]])
        {
            
            [object setValue:[taskDic valueForKey:@"AddedTime"] forKey:@"AddedTime"];
            
            [taskArray replaceObjectAtIndex:i withObject:object];
            
            NSData *jsonData        = [NSJSONSerialization dataWithJSONObject:taskArray options:NSJSONWritingPrettyPrinted error:nil];
            
            NSString *jsonString    = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            [self updateKeychainValue:jsonString forIdentifier:identifier];
            return;
            
        }
        else if([[taskDic valueForKey:@"refID"] isEqualToString:[object valueForKey:@"refID"]])
        {
            [taskArray replaceObjectAtIndex:i withObject:object];
            
            NSData *jsonData        = [NSJSONSerialization dataWithJSONObject:taskArray options:NSJSONWritingPrettyPrinted error:nil];
            
            NSString *jsonString    = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            [self updateKeychainValue:jsonString forIdentifier:identifier];
            return;
        }
        
    }
    
    if ([identifier isEqualToString:keyChainIdentifier])
    {
        [object setValue:[NSString stringWithFormat:@"%@",[NSDate date]] forKey:@"AddedTime"];
    }
    
    [taskArray addObject:object];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:taskArray options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (taskArray.count > 0) {
        [self updateKeychainValue:jsonString forIdentifier:identifier];
    }
    
}

- (void) deleteServiceTaskFromKeyChain:(id)object forIdentifier:(NSString*)identifier
{
    
    NSMutableArray * taskArray ;
    
    NSData *taskData = [self searchKeychainCopyMatching:keyChainIdentifier];
    
    if (taskData)
    {
        taskArray   = [NSJSONSerialization JSONObjectWithData:taskData options:NSJSONReadingMutableContainers error:nil];
    }
    
    for (int i =0; i< taskArray.count; i++)
    {
        NSMutableDictionary * taskDic = [taskArray objectAtIndex:i];
        
        if ([[taskDic valueForKey:@"referenceid"] isEqualToString:[object valueForKey:@"referenceid"]] && [[taskDic valueForKey:@"applicationname"] isEqualToString:[object valueForKey:@"applicationname"]])
        {
            [taskArray removeObjectAtIndex:i];
            if (taskArray.count > 0)
            {
                NSData *jsonData        = [NSJSONSerialization dataWithJSONObject:taskArray options:NSJSONWritingPrettyPrinted error:nil];
                
                NSString *jsonString    = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                [self updateKeychainValue:jsonString forIdentifier:identifier];
            }
            else
            {
                [self updateKeychainValue:@"" forIdentifier:identifier];
            }
            return;
            
        }
        
    }
    
    NSLog(@"NO service tasks in key chain to delete");
}



- (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    
    [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
 
 //   [searchDictionary setObject:@"com.Gss.gssServicePro" forKey:(__bridge id)kSecAttrAccessGroup];
    
    
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [searchDictionary setObject:serviceName forKey:(__bridge id)kSecAttrService];
    
    return searchDictionary;
}

- (NSData *)searchKeychainCopyMatching:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    
    // Add search attributes
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    [searchDictionary setObject:@"com.gss.com.Gss.gssServicePro" forKey:(__bridge id)kSecAttrAccessGroup];
    // Add search return types
    [searchDictionary setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    NSData *result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary,(CFTypeRef)&result);
    
    return result;
}

- (BOOL)createKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier {
    NSMutableDictionary *dictionary = [self newSearchDictionary:identifier];
    
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
   // [dictionary setObject:@"com.Gss.gssServicePro" forKey:(__bridge id)kSecAttrAccessGroup];
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
    
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}

- (BOOL)updateKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier {
    
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [updateDictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)searchDictionary,
                                    (__bridge CFDictionaryRef)updateDictionary);
    
    
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}

- (void)deleteKeychainValue:(NSString *)identifier {
    
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    SecItemDelete((__bridge CFDictionaryRef)searchDictionary);
    
}


@end
