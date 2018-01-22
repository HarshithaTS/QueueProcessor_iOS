//
//  ErrorLog.h
//  GenericQueueProcessor
//
//  Created by Riyas Hassan on 04/11/14.
//  Copyright (c) 2014 GSS Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ErrorLog : NSManagedObject

@property (nonatomic, retain) NSString * referenceID;
@property (nonatomic, retain) NSString * appName;
@property (nonatomic, retain) NSString * apiName;
@property (nonatomic, retain) NSString * errType;
@property (nonatomic, retain) NSString * errDescription;
@property (nonatomic, retain) NSString * errDate;
@property (nonatomic, retain) NSString * status;

@end
