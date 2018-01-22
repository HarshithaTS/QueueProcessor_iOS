//
//  GQPAppDelegate.h
//  GenericQueueProcessor
//
//  Created by Riyas Hassan on 29/10/14.
//  Copyright (c) 2014 GSS Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQPAppDelegate : UIResponder <UIApplicationDelegate>

{
    NSTimer *backGroundTimer;
    UIBackgroundTaskIdentifier backgroundUploadTask; 
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController * mainView;

@property (nonatomic, retain) UINavigationController *mainController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)startBackgroundTask;

@end
