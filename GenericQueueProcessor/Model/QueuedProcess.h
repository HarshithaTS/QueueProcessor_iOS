//
//  QueuedProcess.h
//  GenericQueueProcessor
//
//  Created by Riyas Hassan on 04/11/14.
//  Copyright (c) 2014 GSS Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QueuedProcess : NSManagedObject

@property (nonatomic, retain) NSString * altID;
@property (nonatomic, retain) NSString * apiName;
@property (nonatomic, retain) NSString * appName;
@property (nonatomic, retain) NSString * deviceID;
@property (nonatomic, retain) NSString * endTime;
@property (nonatomic, retain) NSString * inputDataArrayString;
@property (nonatomic, retain) NSString * objectType;
@property (nonatomic, retain) NSString * packageName;
@property (nonatomic, retain) NSString * periority;
@property (nonatomic, retain) NSNumber * processCount;
@property (nonatomic, retain) NSString * processStartTime;
@property (nonatomic, retain) NSString * queueDate;
@property (nonatomic, retain) NSString * referenceID;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * subApplication;
@property (nonatomic, retain) NSString * subApplicationVersion;

@end
