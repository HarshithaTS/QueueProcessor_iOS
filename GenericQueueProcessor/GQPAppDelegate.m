//
//  GQPAppDelegate.m
//  GenericQueueProcessor
//
//  Created by Riyas Hassan on 29/10/14.
//  Copyright (c) 2014 GSS Software. All rights reserved.
//

#import "GQPAppDelegate.h"
#import "GQPViewController.h"
#import "Reachability.h"
#import "GQPQueueProcessor.h"
#import "Constants.h"


@implementation GQPAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[QPLogs sharedInstance]writeLogsToFile:@"Queue Processor started\n"];

    if (IS_IPAD) {
        
        self.mainView = [[GQPViewController alloc] initWithNibName:@"GQPViewController_iPad" bundle:nil];
    }
    else
    {
        self.mainView = [[GQPViewController alloc] initWithNibName:@"GQPViewController" bundle:nil];
    }
    self.mainController = [[UINavigationController alloc] initWithRootViewController:self.mainView];
	self.mainController.navigationBarHidden = NO;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:self.mainController];
	[self.window addSubview:self.mainController.view];
	[self.window makeKeyAndVisible];
    
    [self startReachabilityNotifier];

    [[GQPQueueProcessor sharedInstance] getDataFormKeyChainAndProcess];
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    return YES;

}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    // Display text
//    UIAlertView *alertView;
//    NSString *text = [[url host] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    alertView = [[UIAlertView alloc] initWithTitle:@"Text" message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
    [self openParentApp:nil];
    return YES;
}

-(IBAction) openParentApp:(id)sender {
    // Opens the Receiver app if installed, otherwise displays an error
    UIApplication *ourApplication = [UIApplication sharedApplication];
    NSString *URLEncodedText = [@"This is a test string" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *ourPath = [@"openServiceProApp://" stringByAppendingString:URLEncodedText];//com.gss.genericIOsQueueProcessor/
    NSURL *ourURL = [NSURL URLWithString:ourPath];
    if ([ourApplication canOpenURL:ourURL]) {
        [ourApplication openURL:ourURL];
    }
    else {
        //Display error
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"GSS Parent Application not installed" message:@" " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
    [self applicationDidEnterBackground:[UIApplication sharedApplication]];
    
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [[QPLogs sharedInstance]writeLogsToFile:@"Queue Processor ended\n\n     ***************\n\n"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    [self startBackgroundTask];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[QPLogs sharedInstance]writeLogsToFile:@"Queue Processor started\n"];
    
    [self.mainView viewDidAppear:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    

    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [self openParentApp:nil];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"QueueData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"QueueProcessor.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark Background fetch Methods


- (void)startBackgroundTask
{
    backgroundUploadTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{

    }];
    
    // Start the long-running task and return immediately.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        
        [self startTimer];

    });

    
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
   
    [self startTimer];

}


- (void) startTimer
{

    
    if ([backGroundTimer isValid])
    {
        [ self stopTimer];
        backGroundTimer =  [NSTimer timerWithTimeInterval:120.0
                                                   target:self
                                                 selector:@selector(processDataInQueueToSapWebServer:)
                                                 userInfo:nil
                                                  repeats:YES];
        
    }
    else
    {
        backGroundTimer =  [NSTimer timerWithTimeInterval:00.0
                                                   target:self
                                                 selector:@selector(processDataInQueueToSapWebServer:)
                                                 userInfo:nil
                                                  repeats:YES];
        
    }
    
        [[NSRunLoop mainRunLoop] addTimer:backGroundTimer forMode:NSRunLoopCommonModes];
    
}

- (void)stopTimer
{
    [backGroundTimer invalidate];
}

- (void)processDataInQueueToSapWebServer:(NSTimer*)timer
{
    
}


- (void) startReachabilityNotifier
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    // Start Monitoring
    
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        [reachability startNotifier];
    });
   // [reachability startNotifier];
}


@end
