//
//  LogTextViewController.h
//  GenericQueueProcessor
//
//  Created by Harshitha on 11/23/15.
//  Copyright (c) 2015 GSS Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogTextViewController : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil forLogFile:(NSString*)logFile_name withLogText:(NSString*)logtext;
@end
