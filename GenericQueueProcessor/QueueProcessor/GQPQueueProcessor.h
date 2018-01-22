//
//  GQPQueueProcessor.h
//  GenericQueueProcessor
//
//  Created by Riyas Hassan on 30/10/14.
//  Copyright (c) 2014 GSS Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GssMobileConsoleiOS.h"

@interface GQPQueueProcessor : NSObject<GssMobileConsoleiOSDelegate>
{
    int processItemNumber;
    NSMutableArray *fetchedResultArray;
}

@property (nonatomic) UIBackgroundTaskIdentifier backgroundTask;

+ (id)sharedInstance;

- (void) getDataFormKeyChainAndProcess;

- (void) saveDataToQueueDBFromKeyChain;

- (void)saveInDB:(NSMutableArray*)objectArray;

@property (nonatomic, strong) NSTimer *oneMintTimer, *tenMintsTimer, *oneHrTimer, *fourHrsTimer, *oneDayTimer, *fourDaysTimer, *sevenDaysTimer;

// Added by Harshitha
@property (nonatomic, strong) NSMutableArray *queuedItemArrayWithTimerFired;

@end
