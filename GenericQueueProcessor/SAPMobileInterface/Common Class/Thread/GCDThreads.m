//
//  GCDThreads.m
//  ServiceProUniverse
//
//  Created by GSS Mysore on 1/23/14.
//
//

#import "GCDThreads.h"

@implementation GCDThreads

//Thread code
@synthesize Task_Group_SAPCRM;
@synthesize Main_Queue_SAPCRM;
@synthesize Concurrent_Queue_High_SAPCRM;
@synthesize Concurrent_Queue_Default_SAPCRM;
@synthesize Concurrent_Queue_Low_SAPCRM;


@synthesize Serial_Queue_SAPCRM;
//*****************************************************************************************

static GCDThreads *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (GCDThreads *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}


- (id)init
{
    self = [super init];
    if (self) {
        //Dispatch - Group / Queue - Intilization
        Task_Group_SAPCRM = dispatch_group_create();
        Main_Queue_SAPCRM = dispatch_get_main_queue();
        Concurrent_Queue_High_SAPCRM = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);
        Concurrent_Queue_Default_SAPCRM = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
        Concurrent_Queue_Low_SAPCRM = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,0);
        
        
        //Create despatch queue for call soap webservice;
        Serial_Queue_SAPCRM = dispatch_queue_create("SOAP Calling Queue", DISPATCH_QUEUE_SERIAL);
        
        
        
        //Queue End
    }
    return self;
}

@end
