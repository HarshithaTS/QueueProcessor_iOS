//
//  GCDThreads.h
//  ServiceProUniverse
//
//  Created by GSS Mysore on 1/23/14.
//
//

#import <Foundation/Foundation.h>

@interface GCDThreads : NSObject
{}
//Concurrent Queue
@property (nonatomic, strong) dispatch_group_t Task_Group_SAPCRM;
@property (nonatomic, strong) dispatch_queue_t Main_Queue_SAPCRM;
@property (nonatomic, strong) dispatch_queue_t Concurrent_Queue_High_SAPCRM;
@property (nonatomic, strong) dispatch_queue_t Concurrent_Queue_Default_SAPCRM;
@property (nonatomic, strong) dispatch_queue_t Concurrent_Queue_Low_SAPCRM;


@property (nonatomic, strong) dispatch_queue_t Serial_Queue_SAPCRM;




+ (id)sharedInstance;
@end
