//
//  QPLogs.m
//  GenericQueueProcessor
//
//  Created by Harshitha on 11/20/15.
//  Copyright (c) 2015 GSS Software. All rights reserved.
//

#import "QPLogs.h"

@implementation QPLogs

@synthesize fileExists;

+ (id)sharedInstance
{
    static QPLogs *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (NSString*) getLogFolderPathForPathComponent:(NSString*)pathComponent
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM dd,yyyy"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                        NSUserDomainMask,
                                                                        YES) lastObject];
    NSString *logFolder = [documentsDirectory stringByAppendingPathComponent:pathComponent];
    
    NSString *logFilePath = [NSString stringWithFormat:@"%@/Log %@.txt",logFolder,currentDate];
    fileExists = [[NSFileManager defaultManager] fileExistsAtPath:logFilePath];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    if (![fileManager fileExistsAtPath:logFolder isDirectory:&isDir] && isDir == NO) {
        
        [fileManager createDirectoryAtPath:logFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *currentDateLogs = [logFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"Log %@.txt",currentDate]];
    
    return currentDateLogs;
}

- (void) writeLogsToFile:(NSString*)logtext
{
    NSString *logFolderPath = [self getLogFolderPathForPathComponent:@"QueueProcessorLogs"];
    
    if (fileExists == NO) {
        [logtext writeToFile:logFolderPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        NSArray *logFilesArray = [self fetchLogFilesPath:@"QueueProcessorLogs"];
        
// Log for the current date is created,after which the count increases by 1.As number of logs shudn't exceed 31,when number reaches 32(after adding current date's log),delete the 1st entry
        if (logFilesArray.count == 32) {
            [[NSFileManager defaultManager] removeItemAtPath:[logFilesArray objectAtIndex:1] error:nil];
        }
    }
    else {
        NSFileHandle *fileHandler= [NSFileHandle fileHandleForWritingAtPath:logFolderPath];
        [fileHandler seekToEndOfFile];
        [fileHandler writeData:[logtext dataUsingEncoding:NSUTF8StringEncoding]];
    }
}

- (NSArray*) fetchLogFilesPath:(NSString*)pathComponent
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                        NSUserDomainMask,
                                                                        YES) lastObject];
    NSString *logFolder = [documentsDirectory stringByAppendingPathComponent:pathComponent];
    
    NSArray *logFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[NSURL fileURLWithPath:logFolder] includingPropertiesForKeys:[NSArray array] options:0 error:nil] ;
    
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"pathExtension='txt'"];
    NSArray *logFilesArray = [logFiles filteredArrayUsingPredicate:fltr];
    
    return logFilesArray;
}

- (NSMutableArray*) fetchLogFileNames:(NSString*)pathComponent
{
    NSArray *logFiles = [self fetchLogFilesPath:pathComponent];
    
    NSMutableArray *logFileNamesArray = [[NSMutableArray alloc]init];
    
    for (NSString *logFilePath in logFiles)
    {
        NSString *logFileName = [NSString stringWithFormat:@"%@",logFilePath];
        logFileName = [logFileName stringByReplacingOccurrencesOfString:@"%20" withString:@" "];

        NSRange endRange = [logFileName rangeOfString:@"/" options:NSBackwardsSearch];

        NSRange serachRange = NSMakeRange(endRange.location+1, logFileName.length-endRange.location-5);
        [logFileNamesArray addObject:[logFileName substringWithRange:serachRange]];

    }
    return logFileNamesArray;
}

- (NSString*) readStringFromLogFile:(NSString*)logfileName fromDirectory:(NSString*)dirName
{    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                        NSUserDomainMask,
                                                                        YES) lastObject];
    NSString *logFolder = [documentsDirectory stringByAppendingPathComponent:dirName];
    NSString* logFilePath = [NSString stringWithFormat:@"%@/%@.txt",logFolder,logfileName];
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:logFilePath] encoding:NSUTF8StringEncoding];
}

- (void) addSwipeGestureRecognizerForTarget:(UIViewController*)swipeView withSelctor:(SEL)selector forDirection:(UISwipeGestureRecognizerDirection)direction
{
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:swipeView action:selector];
    [recognizer setDirection:(direction)];
    [swipeView.view addGestureRecognizer:recognizer];
    
}

@end
