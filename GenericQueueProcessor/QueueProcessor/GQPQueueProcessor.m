//
//  GQPQueueProcessor.m
//  GenericQueueProcessor
//
//  Created by Riyas Hassan on 30/10/14.
//  Copyright (c) 2014 GSS Software. All rights reserved.
//

#import "GQPQueueProcessor.h"
#import "Reachability.h"
#import "QueuedProcess.h"
#import "Constants.h"
#import "ErrorLog.h"
#import "GSPKeychainStoreManager.h"
#import "GQPViewController.h"

@implementation GQPQueueProcessor

@synthesize fourDaysTimer,fourHrsTimer,oneDayTimer,oneHrTimer,oneMintTimer,sevenDaysTimer,tenMintsTimer;

@synthesize backgroundTask;

@synthesize queuedItemArrayWithTimerFired;

+ (id)sharedInstance
{
    static GQPQueueProcessor *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


- (void) getDataFormKeyChainAndProcess
{
    [self saveDataToQueueDBFromKeyChain];
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    if ([reachability isReachable])
    {
        NSLog(@"Reachable");
//  ***** Added by Harshitha starts here   *****
        [self deleteItemsWithProcessCountSevenAndErrorStatus];
        
        [self deleteItemsWithCompletedStatus];
        
        [self getDataFromDBAndSendToSAPServer];
        
        [self addTimerToItemsWithoutRetryTimeAdded];
        
//  Original code.....Commented by Harshitha
//        [self start7Timers];
        
        [self start15minTimer];
//  *****  Added by Harshitha ends here   *****
    }
    else
    {
        NSLog(@"Unreachable");
        //Do Nothing
    }
 
}

// Original code.....Commented by Harshitha
/*
- (void) start7Timers
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"QueuedProcess" inManagedObjectContext:context]];
    
    NSError *error                  = nil;
    
   
    NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",1];
    [request setPredicate:predicate];
    
    NSMutableArray * processCountOneArray      = (NSMutableArray*)[context executeFetchRequest:request error:&error];
    
    if (processCountOneArray.count > 0)
    {
        oneMintTimer    = [NSTimer timerWithTimeInterval:60.0 target:self selector:@selector(processDataInQueueTableToSapWebServer:) userInfo:@"1 Mint" repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:oneMintTimer forMode:NSRunLoopCommonModes];
    }
    
    predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",2];
    [request setPredicate:predicate];
    
    NSMutableArray * processCountTwoArray      = (NSMutableArray*)[context executeFetchRequest:request error:&error];
    
    if (processCountTwoArray.count > 0)
    {
        tenMintsTimer   = [NSTimer timerWithTimeInterval:600.0 target:self selector:@selector(processDataInQueueTableToSapWebServer:) userInfo:@"10 Mints" repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:tenMintsTimer forMode:NSRunLoopCommonModes];
    }
    
    predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",3];
    [request setPredicate:predicate];
    
    NSMutableArray * processCountThreeArray      = (NSMutableArray*)[context executeFetchRequest:request error:&error];
    
    if (processCountThreeArray.count > 0)
    {
        oneHrTimer      = [NSTimer timerWithTimeInterval:3600.0 target:self selector:@selector(processDataInQueueTableToSapWebServer:) userInfo:@"1 Hour" repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:oneHrTimer forMode:NSRunLoopCommonModes];
    }
    
    predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",4];
    [request setPredicate:predicate];
    
    NSMutableArray * processCountFourArray      = (NSMutableArray*)[context executeFetchRequest:request error:&error];
    
    if (processCountFourArray.count > 0)
    {
        fourHrsTimer    = [NSTimer timerWithTimeInterval:14400.0 target:self selector:@selector(processDataInQueueTableToSapWebServer:) userInfo:@"4 Hours" repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:fourHrsTimer forMode:NSRunLoopCommonModes];
    }
    
    predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",5];
    [request setPredicate:predicate];
    
    NSMutableArray * processCountFiveArray      = (NSMutableArray*)[context executeFetchRequest:request error:&error];
    
    if (processCountFiveArray.count > 0)
    {
        oneDayTimer     = [NSTimer timerWithTimeInterval:86400.0 target:self selector:@selector(processDataInQueueTableToSapWebServer:) userInfo:@"1 Day" repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:oneDayTimer forMode:NSRunLoopCommonModes];
    }
    
    predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",6];
    [request setPredicate:predicate];
    
    NSMutableArray * processCountSixArray      = (NSMutableArray*)[context executeFetchRequest:request error:&error];
    
    if (processCountSixArray.count > 0)
    {
        fourDaysTimer   = [NSTimer timerWithTimeInterval:345600.0 target:self selector:@selector(processDataInQueueTableToSapWebServer:) userInfo:@"4 Days" repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:fourDaysTimer forMode:NSRunLoopCommonModes];
    }
    
    predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",7];
    [request setPredicate:predicate];
    
    NSMutableArray * processCountSevenArray      = (NSMutableArray*)[context executeFetchRequest:request error:&error];
    
    if (processCountSevenArray.count > 0)
    {
        sevenDaysTimer  = [NSTimer timerWithTimeInterval:604800.0 target:self selector:@selector(processDataInQueueTableToSapWebServer:) userInfo:@"7 Days" repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:sevenDaysTimer forMode:NSRunLoopCommonModes];
    }
    
}


- (void)processDataInQueueTableToSapWebServer:(NSTimer*)timer
{
    NSString * timerInfo = timer.userInfo;
    
    NSLog(@"Timer info is : %@", timerInfo);
    
    
    NSMutableArray *tempArray = [NSMutableArray new];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"QueuedProcess" inManagedObjectContext:context]];
    
     NSError *error                  = nil;
    
    
    if ([timerInfo isEqualToString:@"1 Mint"])
    {
        NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",1];
        [request setPredicate:predicate];
    }
    else if ([timerInfo isEqualToString:@"10 Mints"])
    {
        NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",2];
        [request setPredicate:predicate];
    }
    
    else if ([timerInfo isEqualToString:@"1 Hour"])
    {
        NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",3];
        [request setPredicate:predicate];
    }
    else if ([timerInfo isEqualToString:@"4 Hours"])
    {
        NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",4];
        [request setPredicate:predicate];
    }
    else if ([timerInfo isEqualToString:@"1 Day"])
    {
        NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",5];
        [request setPredicate:predicate];
    }
    else if ([timerInfo isEqualToString:@"4 Days"])
    {
        NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",6];
        [request setPredicate:predicate];
    }
    else if ([timerInfo isEqualToString:@"7 Days"])
    {
        NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"processCount = %d",7];
        [request setPredicate:predicate];
    }
 
    
   
    tempArray              = (NSMutableArray*)[context executeFetchRequest:request error:&error];

    for (int i = 0; i < tempArray.count ; i++)
    {
        [self updateProcessStartedDetailsInDBForObject:[tempArray objectAtIndex:i]];
        [self initializeWebServiceCallForObject:[tempArray objectAtIndex:i]];
    }

}
*/

// *****  Added by Harshitha starts here *****
- (void) setNextTimerForRefID : (NSString *)refId andAppName : (NSString *)appName
{
    int processCount;
    QueuedProcess *coredataObject;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"QueuedProcess" inManagedObjectContext:context]];
    
    NSError *error                  = nil;
    NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"referenceID = %@ AND appName = %@", refId,appName];
    [request setPredicate:predicate];
    NSArray *results                = [context executeFetchRequest:request error:&error];
    
    if (results.count > 0)
    {
        coredataObject   = (QueuedProcess*)[results objectAtIndex:0];
        
        processCount         = [[coredataObject valueForKey:@"processCount"] intValue];
    }
    switch (processCount) {
            
        case 1:
            oneMintTimer    = [NSTimer timerWithTimeInterval:60.0 target:self selector:@selector(addQueuedItemToProcessArray:) userInfo:coredataObject repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:oneMintTimer forMode:NSRunLoopCommonModes];
            break;

        case 2:
            tenMintsTimer   = [NSTimer timerWithTimeInterval:600.0 target:self selector:@selector(addQueuedItemToProcessArray:) userInfo:coredataObject repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:tenMintsTimer forMode:NSRunLoopCommonModes];
            break;
            
        case 3:
            oneHrTimer      = [NSTimer timerWithTimeInterval:3600.0 target:self selector:@selector(addQueuedItemToProcessArray:) userInfo:coredataObject repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:oneHrTimer forMode:NSRunLoopCommonModes];
            break;
            
        case 4:
            fourHrsTimer    = [NSTimer timerWithTimeInterval:14400.0 target:self selector:@selector(addQueuedItemToProcessArray:) userInfo:coredataObject repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:fourHrsTimer forMode:NSRunLoopCommonModes];
            break;
            
        case 5:
            oneDayTimer     = [NSTimer timerWithTimeInterval:86400.0 target:self selector:@selector(addQueuedItemToProcessArray:) userInfo:coredataObject repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:oneDayTimer forMode:NSRunLoopCommonModes];
            break;
            
        case 6:
            fourDaysTimer   = [NSTimer timerWithTimeInterval:345600.0 target:self selector:@selector(addQueuedItemToProcessArray:) userInfo:coredataObject repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:fourDaysTimer forMode:NSRunLoopCommonModes];
            break;
            
        case 7:
            sevenDaysTimer  = [NSTimer timerWithTimeInterval:604800.0 target:self selector:@selector(addQueuedItemToProcessArray:)userInfo:coredataObject repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:sevenDaysTimer forMode:NSRunLoopCommonModes];
            break;
            
        default:
            break;
    }
}

- (void) addQueuedItemToProcessArray : (NSTimer*)timer
{
    QueuedProcess *coreDataObject = timer.userInfo;
    
    if (queuedItemArrayWithTimerFired.count == 0)
        queuedItemArrayWithTimerFired = [[NSMutableArray alloc]init];
    [queuedItemArrayWithTimerFired addObject:coreDataObject];
}

- (void) start15minTimer
{
    [NSTimer scheduledTimerWithTimeInterval:900 target:self selector:@selector(processQueueDataWhenTimerFired) userInfo:nil repeats:YES];
}

- (void) processQueueDataWhenTimerFired
{
    [[QPLogs sharedInstance]writeLogsToFile:[NSString stringWithFormat:@"15 minutes timer fired\n"]];
    
    [self deleteItemsWithProcessCountSevenAndErrorStatus];
    
    [self saveErrorItemsInKeyChain];
    
    [self deleteItemsWithCompletedStatus];
    
    [self addTimerToItemsWithoutRetryTimeAdded];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshQueueTableView" object:nil];
    
    for (int i = 0; i < queuedItemArrayWithTimerFired.count ; i++)
    {
        [self updateProcessStartedDetailsInDBForObject:[queuedItemArrayWithTimerFired objectAtIndex:i]];
        
        [[QPLogs sharedInstance]writeLogsToFile:[NSString stringWithFormat:@"For Reference ID : %@\tProcess Count : %@\n",[[queuedItemArrayWithTimerFired objectAtIndex:i]valueForKey:@"referenceID"],[[queuedItemArrayWithTimerFired objectAtIndex:i]valueForKey:@"processCount"]]];
        
        [self initializeWebServiceCallForObject:[queuedItemArrayWithTimerFired objectAtIndex:i]];
        
        [queuedItemArrayWithTimerFired removeObject:[queuedItemArrayWithTimerFired objectAtIndex:i]];
    }
}
// *****  Added by Harshitha ends here *****

- (void) saveDataToQueueDBFromKeyChain
{
    
    NSMutableArray * arrayOfTasksFromKeyChain = [GSPKeychainStoreManager arrayFromKeychain];
    
    [self saveInDB:arrayOfTasksFromKeyChain];
    
}

- (void)getDataFromDBAndSendToSAPServer
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"QueuedProcess" inManagedObjectContext:context]];
    
//  Original code
//    NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"status != %@ OR status = NULL",@"Completed" ];// OR status != %@,@"Processing"];
    
//    Modified by Harshitha.....As completed items are already processed and need to be deleted from the queue,it doesn't require another web-service call
    NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"status = NULL"];
    [request setPredicate:predicate];
    
    NSError *error                  = nil;
    fetchedResultArray              = (NSMutableArray*)[context executeFetchRequest:request error:&error];
    
// Added by Harshitha to process queued items acc. to priority
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"periority" ascending:YES];
    NSArray *results = [fetchedResultArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    [fetchedResultArray arrayByAddingObjectsFromArray:results];
    
    processItemNumber = 0;
    [self processWebServiceRequestToSap];

}


- (void)processWebServiceRequestToSap
{
    if (processItemNumber < fetchedResultArray.count  )
    {
//  Addded by Harshitha to add logs
        [[QPLogs sharedInstance]writeLogsToFile:[NSString stringWithFormat:@"Calling webservice for Reference ID : %@ of Application : %@ with Process Count : %@\n",[[fetchedResultArray objectAtIndex:processItemNumber]valueForKey:@"referenceID"],[[fetchedResultArray objectAtIndex:processItemNumber]valueForKey:@"appName"],[[fetchedResultArray objectAtIndex:processItemNumber]valueForKey:@"processCount"]]];
        
        [self updateProcessStartedDetailsInDBForObject:[fetchedResultArray objectAtIndex:processItemNumber]];
        [self initializeWebServiceCallForObject:[fetchedResultArray objectAtIndex:processItemNumber]];
        processItemNumber++;
    }
    else if (fetchedResultArray.count <= 0 || fetchedResultArray == nil)
    {
        //Do Nothing. Stop Processing
    }
    else
    {
        processItemNumber   = 0;
        fetchedResultArray  = nil;
        //[self getDataFromDBAndSendToSAPServer];
    }
  
}


- (void)initializeWebServiceCallForObject:(QueuedProcess*)object
{
    GssMobileConsoleiOS *objServiceMngtCls      = [[GssMobileConsoleiOS alloc] init];
    
    objServiceMngtCls.ApplicationName           = [object valueForKey:@"appName"];
    objServiceMngtCls.ApplicationVersion        = [object valueForKey:@"subApplicationVersion"];
    objServiceMngtCls.ApplicationEventAPI       = [object valueForKey:@"apiName"];
    
    NSString *tempStr                           = [object valueForKey:@"inputDataArrayString"];
    objServiceMngtCls.InputDataArray            = [self createMutableArray:[tempStr componentsSeparatedByString:@","]];
    objServiceMngtCls.Options                   = @"UPDATEDATA";
    objServiceMngtCls.RefernceID                = [object valueForKey:@"referenceID"];
    
    objServiceMngtCls.subApp                    = [object valueForKey:@"subApplication"];
    objServiceMngtCls.objectType                = [object valueForKey:@"objectType"];
    
    
    //objServiceMngtCls.CRMdelegate              = self;
    
//  Added by Harshitha.....To add SOAP request to logs
    [[QPLogs sharedInstance]writeLogsToFile:[NSString stringWithFormat:@"SOAP Request : %@\n",objServiceMngtCls.InputDataArray]];
    
    [objServiceMngtCls callSOAPWebMethodWithBlock:^(GQPWebServiceResponse * response)
     {

         
        if (response.responseArray) {
            
//  Added by Harshitha.....To add SOAP response to logs
            [[QPLogs sharedInstance]writeLogsToFile:[NSString stringWithFormat:@"SOAP Response : %@\n",[[objServiceMngtCls valueForKey:@"objInputProperties"] valueForKey:@"responseArrayStr"]]];
            
             if (response.responseArray.count > 3)
             {
                 NSString * message = [[response.responseArray objectAtIndex:0] objectAtIndex:0];
                 
                 if ([message isEqualToString:@"E"])
                 {
                     //Update Error table
                     NSLog(@"Error for reference id : %@",response.referenceID );
                     
                     [self updateProcessStatusInDBForObjectWithReferenceID:response.referenceID withStatus:@"Error"];
                     [self updateErrorTableForReferenceId:response.referenceID andErrorObject:response.responseArray andErrorMessage:@"Error"];
                     
                 }
                 else  if ([message isEqualToString:@"S"])
                 {
                     // Update success status in Db
                     NSLog(@"Success for reference id : %@",response.referenceID );
                     [self updateProcessStatusInDBForObjectWithReferenceID:response.referenceID withStatus:@"Completed"];
                 }
             }
         }
         
         else if (response.errorResponseMessage)
         {
             
//  Added by Harshitha.....To add SOAP response to logs
             [[QPLogs sharedInstance]writeLogsToFile:[NSString stringWithFormat:@"SOAP Response : %@\n",[[objServiceMngtCls valueForKey:@"objInputProperties"] valueForKey:@"responseArrayStr"]]];
             
             [self updateProcessStatusInDBForObjectWithReferenceID:response.referenceID withStatus:@"Error"];
             
             [self updateErrorTableForReferenceId:response.referenceID andErrorObject:response.responseArray andErrorMessage:response.errorResponseMessage];
         }
         
         
         [self processWebServiceRequestToSap];
     }];
}


- (NSMutableArray *)createMutableArray:(NSArray *)array
{
    return [array mutableCopy];
}


#pragma mark coredata methods

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)saveInDB:(NSMutableArray*)objectArray
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    
    
    for (NSDictionary * taskDic in objectArray)
    {
        NSLog(@"item is %@", [taskDic objectForKey:@"referenceid"] );
    
        [self checkAndDeleteRecordsAlreadyExistsDB:@"QueuedProcess" forRefID:[taskDic objectForKey:@"referenceid"] andApplicationName:[taskDic objectForKey:@"applicationname"]];
        
        NSManagedObject *process = [NSEntityDescription insertNewObjectForEntityForName:@"QueuedProcess" inManagedObjectContext:context];
        
        
        [process setValue:[taskDic objectForKey:@"applicationname"] forKey:@"appName"];
        [process setValue:[taskDic objectForKey:@"referenceid"] forKey:@"referenceID"];
        [process setValue:[taskDic objectForKey:@"packageName"] forKey:@"packageName"];
        [process setValue:[taskDic objectForKey:@"AddedTime"] forKey:@"queueDate"];
        
        [process setValue:[NSNumber numberWithInt:[[taskDic objectForKey:@"attempt"]integerValue]] forKey:@"processCount"];
        [process setValue:[taskDic objectForKey:@"inputdataarraystring"] forKey:@"inputDataArrayString"];
        [process setValue:[taskDic objectForKey:@"objecttype"] forKey:@"objectType"];
        [process setValue:[taskDic objectForKey:@"periority"] forKey:@"periority"];
        [process setValue:[taskDic objectForKey:@"subapplication"] forKey:@"subApplication"];
        [process setValue:[taskDic objectForKey:@"subapplicationversion"] forKey:@"subApplicationVersion"];
        
        [process setValue:[taskDic objectForKey:@"applicationeventapi"] forKey:@"apiName"];
        [process setValue:[taskDic objectForKey:@"ID"] forKey:@"altID"];
        [process setValue:[taskDic objectForKey:@"created"] forKey:@"processStartTime"];
        [process setValue:[taskDic objectForKey:@"deviceid"] forKey:@"deviceID"];
        [process setValue:[taskDic objectForKey:@"endtime"] forKey:@"endTime"];

        
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        else
        {
            NSLog(@"Saved successfully");
        }
        
    }

    [GSPKeychainStoreManager deleteItemsFromKeyChain];
}

- (void)checkAndDeleteRecordsAlreadyExistsDB:(NSString*)entityName forRefID:(NSString*)objectID andApplicationName:(NSString*)appName
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];//@"QueuedProcess"
    
    NSError *error                  = nil;
    NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"referenceID = %@ AND appName = %@", objectID,appName];
    [request setPredicate:predicate];
    NSArray *results                = [context executeFetchRequest:request error:&error];
    
    if (results.count > 0)
    {
        for (NSManagedObject* object in results)
        {
            [context deleteObject:object];
        }
        
        [context save:&error];
    }
    
}

- (void)updateProcessStartedDetailsInDBForObject:(QueuedProcess*)object
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"QueuedProcess" inManagedObjectContext:context]];
    
    NSError *error                  = nil;
    NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"referenceID = %@ AND appName = %@", object.referenceID,object.appName];
    [request setPredicate:predicate];
    NSArray *results                = [context executeFetchRequest:request error:&error];
    if (results.count > 0)
    {
        NSManagedObject *coredataObject = [results objectAtIndex:0];
        
        NSNumber *processCount          = [coredataObject valueForKey:@"processCount"];
        
        processCount                    = [NSNumber numberWithInt:[processCount integerValue] + 1 ];
        
        [coredataObject setValue:processCount forKey:@"processCount"];
        [coredataObject setValue:@"Processing" forKey:@"status"];
        
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
//        [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        [DateFormatter setDateFormat:@"MMM dd,yyyy HH:mm"];

        [coredataObject setValue:[NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:[NSDate date]]] forKey:@"processStartTime"];
        
        
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        else
        {
            NSLog(@"Saved successfully");
        }

        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshQueueTableView" object:nil];

    }
    
}


- (void)updateProcessStatusInDBForObjectWithReferenceID:(NSString*)refId withStatus:(NSString*)status
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"QueuedProcess" inManagedObjectContext:context]];
    
    NSError *error                  = nil;
    NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"referenceID = %@",refId];
    [request setPredicate:predicate];
    NSArray *results                = [context executeFetchRequest:request error:&error];
    
    if (results.count > 0)
    {
        NSManagedObject *coredataObject = [results objectAtIndex:0];
        
        [coredataObject setValue:status forKey:@"status"];
        [coredataObject setValue:[NSString stringWithFormat:@"%@",[NSDate date]] forKey:@"endTime"];
        
        
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        else
        {
            NSLog(@"Saved successfully");
        }

    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshQueueTableView" object:nil];
    }
}

- (void) updateErrorTableForReferenceId:(NSString*)refId andErrorObject:(NSMutableArray*)responseObject andErrorMessage:(NSString*)errorMessage
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"QueuedProcess" inManagedObjectContext:context]];
    
    NSError *error                  = nil;
    NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"referenceID = %@",refId];
    [request setPredicate:predicate];
    NSArray *results                = [context executeFetchRequest:request error:&error];
    
    if (results.count > 0)
    {
        QueuedProcess *coredataObject   = (QueuedProcess*)[results objectAtIndex:0];
    
        NSNumber *processCount         = [coredataObject valueForKey:@"processCount"];
    
// Original code
//    if ([processCount integerValue] >= 7){
//  Modified by Harshitha
        if ([processCount integerValue] <= 7){
    
            [self checkAndDeleteRecordsAlreadyExistsDB:@"ErrorLog"  forRefID:refId andApplicationName:[coredataObject valueForKey:@"appName"]];
        
            if (responseObject.count > 0) {
            
                NSArray *errResponseArray   = [responseObject objectAtIndex:0];
            
                NSString *errorType         = [errResponseArray objectAtIndex:0];
                errResponseArray            = [responseObject objectAtIndex:3];
                NSString * errorDesc        = [errResponseArray objectAtIndex:0];
            
            [   self insertNewErrorRecordInDbWithRefID:refId andCoredatObj:coredataObject errorType:errorType andEroorDesc:errorDesc];
            }
            else
            {
                [self insertNewErrorRecordInDbWithRefID:refId andCoredatObj:coredataObject errorType:errorMessage andEroorDesc:errorMessage];
            }
        }
    }
        
    [self saveErrorItemsInKeyChain];
    [self setNextTimerForRefID:refId andAppName:[(QueuedProcess*)[results objectAtIndex:0] valueForKey:@"appName"]];
    
}


- (void)insertNewErrorRecordInDbWithRefID:(NSString*)refID andCoredatObj:(QueuedProcess*)coreDataObj errorType:(NSString*)errorType andEroorDesc:(NSString*)errorDesc
{
    
     [self checkAndDeleteRecordsAlreadyExistsDB:@"ErrorLog"  forRefID:refID andApplicationName:[coreDataObj valueForKey:@"appName"]];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSManagedObject *errorLog = [NSEntityDescription insertNewObjectForEntityForName:@"ErrorLog" inManagedObjectContext:context];

    [errorLog setValue:refID forKey:@"referenceID"];
    [errorLog setValue:[coreDataObj valueForKey:@"appName"] forKey:@"appName"];
    [errorLog setValue:[coreDataObj valueForKey:@"apiName"] forKey:@"apiName"];
    [errorLog setValue:errorType forKey:@"errType"];
    [errorLog setValue:errorDesc forKey:@"errDescription"];
    [errorLog setValue:[NSString stringWithFormat:@"%@",[NSDate date]] forKey:@"errDate"];
    [errorLog setValue:@"ERROR" forKey:@"status"];
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else
    {
        NSLog(@"Saved successfully");
    }

}

- (NSMutableArray*) getErrorOccuredItemsFromDB
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"ErrorLog" inManagedObjectContext:context]];
    
    NSError *error                  = nil;
    NSArray *results                = [context executeFetchRequest:request error:&error];

    return (NSMutableArray*)results;
}


- (void)saveErrorItemsInKeyChain
{
    
    NSMutableArray * errorItems = [self getErrorOccuredItemsFromDB];
    
//  Original code
//    [GSPKeychainStoreManager saveErrorItemsInKeychain:erorrItems];

// *****   Modified by Harshitha starts here   *****
    NSMutableArray *errorLogArray = [[NSMutableArray alloc]init];
    
    if (errorItems.count > 0)
    {
        for (NSString *errorField in errorItems)
        {
            NSMutableDictionary *errorLogDict = [NSMutableDictionary new];
            [errorLogArray addObject:errorLogDict];
            
            [errorLogDict setObject:[errorField valueForKey:@"referenceID"] forKey:@"referenceID"];
            [errorLogDict setObject:[errorField valueForKey:@"appName"] forKey:@"appName"];
            [errorLogDict setObject:[errorField valueForKey:@"apiName"] forKey:@"apiName"];
            [errorLogDict setObject:[errorField valueForKey:@"errType"] forKey:@"errType"];
            [errorLogDict setObject:[errorField valueForKey:@"errDescription"] forKey:@"errDescription"];
            [errorLogDict setObject:[errorField valueForKey:@"errDate"] forKey:@"errDate"];
            [errorLogDict setObject:[errorField valueForKey:@"status"] forKey:@"status"];
        }
        [GSPKeychainStoreManager saveErrorItemsInKeychain:errorLogArray];
    }
    else
    {
        [GSPKeychainStoreManager deleteErrorItemsFromKeyChain];
    }
// *****   Modified by Harshitha ends here   *****
}

//  *****   Added by Harshitha starts here   *****
- (void) deleteItemsWithProcessCountSevenAndErrorStatus
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"QueuedProcess" inManagedObjectContext:context]];
    
    NSError *error                  = nil;
    NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"processCount > 7"];
    [request setPredicate:predicate];
    NSArray *results                = [context executeFetchRequest:request error:&error];
    
    if (results.count > 0)
    {
        for (NSManagedObject* object in results)
        {
            NSString *refID = [object valueForKey:@"referenceID"];
            NSString *applnName = [object valueForKey:@"appName"];
            
            [self checkAndDeleteRecordsAlreadyExistsDB:@"ErrorLog"  forRefID:[object valueForKey:@"referenceID"] andApplicationName:[object valueForKey:@"appName"]];
            
            [self checkAndDeleteRecordsAlreadyExistsDB:@"QueuedProcess"  forRefID:[object valueForKey:@"referenceID"] andApplicationName:[object valueForKey:@"appName"]];
            
            [[QPLogs sharedInstance]writeLogsToFile:[NSString stringWithFormat:@"Item : %@ of application : %@ is processed with error and deleted from queue\n",refID,applnName]];
            
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            [localNotification setAlertAction:@"Launch"];
            [localNotification setAlertBody:[NSString stringWithFormat:@"Item : %@ of application : %@ is processed with error and deleted from queue\n",refID,applnName]];
            [localNotification setHasAction: YES];
            [localNotification setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber]+1];
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

        }
    }
}

- (void) deleteItemsWithCompletedStatus
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"QueuedProcess" inManagedObjectContext:context]];
    
    NSError *error                  = nil;
    NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"status = %@",@"Completed"];
    [request setPredicate:predicate];
    NSArray *results                = [context executeFetchRequest:request error:&error];
    
    if (results.count > 0)
    {
        for (NSManagedObject* object in results)
        {
            [[QPLogs sharedInstance]writeLogsToFile:[NSString stringWithFormat:@"Item : %@ of application : %@ is completed and deleted from queue\n",[object valueForKey:@"referenceID"],[object valueForKey:@"appName"]]];
            
            [self checkAndDeleteRecordsAlreadyExistsDB:@"QueuedProcess"  forRefID:[object valueForKey:@"referenceID"] andApplicationName:[object valueForKey:@"appName"]];

            [self checkAndDeleteRecordsAlreadyExistsDB:@"ErrorLog"  forRefID:[object valueForKey:@"referenceID"] andApplicationName:[object valueForKey:@"appName"]];
        }
    }
}

- (void) addTimerToItemsWithoutRetryTimeAdded
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"ErrorLog" inManagedObjectContext:context]];
    
    NSError *error                  = nil;

    NSArray *results                = [context executeFetchRequest:request error:&error];
    
    if (results.count > 0)
    {
        for (NSManagedObject* object in results)
        {
            BOOL timerAddedForItem = NO;
            for (int i = 0 ; i < queuedItemArrayWithTimerFired.count ; i++)
            {
                if ([[object valueForKey:@"referenceID"] isEqualToString:[[queuedItemArrayWithTimerFired objectAtIndex:i]valueForKey:@"referenceID"]] && [[object valueForKey:@"appName"] isEqualToString:[[queuedItemArrayWithTimerFired objectAtIndex:i]valueForKey:@"appName"]])
                {
                    timerAddedForItem = YES;
                }
            }
            if (timerAddedForItem == NO)
            {
                [self setNextTimerForRefID:[object valueForKey:@"referenceID"] andAppName:[object valueForKey:@"appName"]];
            }
        }
    }
}
//  *****   Added by Harshitha ends here   *****

@end
