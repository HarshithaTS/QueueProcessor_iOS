//
//  GSSBackgroundTask.h
//  GssServiceproBeta
//
//  Created by GSS Mysore on 8/12/14.
//  Copyright (c) 2014 GSS Mysore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "GCDThreads.h"

@interface GSSBackgroundTask : NSObject
{
    __block UIBackgroundTaskIdentifier bgTask;
    __block dispatch_block_t expirationHandler;
    __block NSTimer * timer;
    __block AVAudioPlayer *player;
    
    NSInteger timerInterval;
    id target;
    SEL selector;
    
    GCDThreads *objGCDThreads;
}





-(void) startBackgroundTasks:(NSInteger)time_  target:(id)target_ selector:(SEL)selector_;
-(void) stopBackgroundTask;
@end
