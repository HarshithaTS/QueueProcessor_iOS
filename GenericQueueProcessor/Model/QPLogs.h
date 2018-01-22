//
//  QPLogs.h
//  GenericQueueProcessor
//
//  Created by Harshitha on 11/20/15.
//  Copyright (c) 2015 GSS Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QPLogs : NSObject

+ (id)sharedInstance;

@property (nonatomic, assign) BOOL fileExists;

- (NSString*) getLogFolderPathForPathComponent:(NSString*)pathComponent;

- (void) writeLogsToFile:(NSString*)logtext;

- (NSMutableArray*) fetchLogFileNames:(NSString*)pathComponent;

- (NSString*) readStringFromLogFile:(NSString*)logfileName fromDirectory:(NSString*)dirName;

- (void) addSwipeGestureRecognizerForTarget:(UIViewController*)swipeView withSelctor:(SEL)selector forDirection:(UISwipeGestureRecognizerDirection)direction;

@end
