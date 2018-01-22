//
//  GSPKeychainStoreManager.m
//  GssServicePro
//
//  Created by Riyas Hassan on 08/01/15.
//  Copyright (c) 2015 Riyas Hassan. All rights reserved.
//

#import "GSPKeychainStoreManager.h"
#import "UICKeyChainStore.h"

@implementation GSPKeychainStoreManager


+ (NSString*) stringFromArray:(NSMutableArray*)contentArray
{
    NSData *jsonData        = [NSJSONSerialization dataWithJSONObject:contentArray options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonString    = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

+ (NSMutableArray*) arrayFromString:(NSString*)string
{
    NSMutableArray *objectArray = [NSMutableArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL]];
    
    return objectArray;
}



+ (NSMutableArray*) consolitedArrayFromKeyChainAndLocalDB:(NSMutableArray*)arrayFromDB
{
    UICKeyChainStore *store             = [UICKeyChainStore keyChainStoreWithService:@"com.GSSServicePro"];
    
    NSString *stringFromKeychain        = [store stringForKey:@"queueData"];
    
    NSMutableArray *arrayFromKeychain;
    
    if (stringFromKeychain)
    {
        arrayFromKeychain               = [GSPKeychainStoreManager arrayFromString:stringFromKeychain];
        
    }
    
    for (NSDictionary * qpObject in arrayFromDB) {
        
        for (int i =0; i< arrayFromKeychain.count; i++)
        {
            NSMutableDictionary * taskDic = [arrayFromKeychain objectAtIndex:i];
            
            if ([[taskDic valueForKey:@"referenceid"] isEqualToString:[qpObject valueForKey:@"referenceid"]] && [[taskDic valueForKey:@"applicationname"] isEqualToString:[qpObject valueForKey:@"applicationname"]] && [[taskDic valueForKey:@"ID"] isEqualToString:[qpObject valueForKey:@"ID"]])
            {
                
                [qpObject setValue:[taskDic valueForKey:@"AddedTime"] forKey:@"AddedTime"];
                
                [arrayFromKeychain replaceObjectAtIndex:i withObject:qpObject];
                
            }
            else if([[taskDic valueForKey:@"refID"] isEqualToString:[qpObject valueForKey:@"refID"]])
            {
                [arrayFromKeychain replaceObjectAtIndex:i withObject:qpObject];
                
            }
        }
    }
    
    if (arrayFromKeychain.count <= 0 || arrayFromKeychain == nil) {
        
        return arrayFromDB;
    }
    else
        
        return arrayFromKeychain;
    
}

+ (void)saveDataInKeyChain:(NSMutableArray*)array
{
    UICKeyChainStore *store         = [UICKeyChainStore keyChainStoreWithService:@"com.GSSServicePro"];
    
    
    NSMutableArray * arrayToStore   = [GSPKeychainStoreManager consolitedArrayFromKeyChainAndLocalDB:array];
    
    if (arrayToStore.count > 0) {
        NSString *stringToStore         = [GSPKeychainStoreManager stringFromArray:arrayToStore];
        
        [UICKeyChainStore setString:stringToStore forKey:@"queueData" service:@"com.GSSServicePro"];
        [store synchronize];
    }

}

+ (NSMutableArray*) arrayFromKeychain
{
    UICKeyChainStore *store             = [UICKeyChainStore keyChainStoreWithService:@"com.GSSServicePro"];
    
    NSString *stringFromKeychain        = [store stringForKey:@"queueData"];
    
    NSMutableArray *array;
    
    if (stringFromKeychain)
    {
        array               = [GSPKeychainStoreManager arrayFromString:stringFromKeychain];
        
    }
    return array;
}

+ (void) deleteItemsFromKeyChain
{
    
    [UICKeyChainStore removeAllItemsForService:@"com.GSSServicePro"];
}


+(void) saveErrorItemsInKeychain:(NSMutableArray*)array
{
    UICKeyChainStore *store         = [UICKeyChainStore keyChainStoreWithService:@"com.ServiceProError"];
    
    if (array.count >0)
    {
        NSString *stringToStore         = [GSPKeychainStoreManager stringFromArray:array];
        
        [UICKeyChainStore setString:stringToStore forKey:@"Error" service:@"com.ServiceProError"];
        [store synchronize];
    }

    
}


+ (NSMutableArray*)getErrorItemsFromKeyChain
{
    UICKeyChainStore *store             = [UICKeyChainStore keyChainStoreWithService:@"com.ServiceProError"];
    
    NSString *stringFromKeychain        = [store stringForKey:@"Error"];
    
    NSMutableArray *array;
    
    if (stringFromKeychain)
    {
        array               = [GSPKeychainStoreManager arrayFromString:stringFromKeychain];
        
    }
    return array;
}

// Added by Harshitha
+ (void) deleteErrorItemsFromKeyChain
{
    
    [UICKeyChainStore removeAllItemsForService:@"com.ServiceProError"];
}

@end
