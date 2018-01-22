//
//  GSSQProcessor.h
//  GssServiceproBeta
//
//  Created by GSS Mysore on 8/11/14.
//  Copyright (c) 2014 GSS Mysore. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GssMobileConsoleiOS.h"

@class KeychainItemWrapper;


@interface GSSQProcessor : NSObject <GssMobileConsoleiOSDelegate>
{
    GssMobileConsoleiOS *objServiceMngtCls;

}

extern NSString *const QdbName;

@property (nonatomic, strong, readonly) KeychainItemWrapper *keychainItem;

@property (retain, nonatomic) NSString *attemptCnt;
@property (retain, nonatomic) NSString *periority;
@property (retain, nonatomic) NSString *refID;

@property (retain, nonatomic) NSString *qID;
@property (assign) int logID;

@property (retain, nonatomic) NSString *errorType;
@property (retain, nonatomic) NSString *errorDesc;


@property (retain, nonatomic) NSMutableArray *qPReturnData;

@property (retain, nonatomic) NSString *qStatus;


-(BOOL) putDataIntoQtable;
-(NSMutableArray *) getAllQPData;
-(NSMutableArray *) getNewQdata;
-(NSMutableArray *) getPendingQdata;
-(NSMutableArray *) getQPData:(NSString *)status QattemptCount:(int*)attemptcnt;
-(void) initialQueueDataforWebserviceCall;
-(void) startProcessQueuedData;
-(NSMutableArray *)createMutableArray:(NSArray *)array;
-(BOOL) updateQdata:(NSString *) mperiority count:(NSString *)mcount refereneid:(NSString *) mrefID;
-(BOOL) updateQdata:(NSString *) mstatus QueueID:(NSString *) mQID;
-(BOOL) checkQPData:(NSString *) mAppName ObjectType:(NSString *)mObjType SubApplication:(NSString *)mSubApp ReferenceID:(NSString *) mrefID;
-(BOOL) deleteQdata:(NSString *) mRefID;
-(int) insertIntoLogTable:(NSString *) mrefID queueid:(NSString *) mqid description:(NSString *) desc;


@end
