//
//  LogTextViewController.m
//  GenericQueueProcessor
//
//  Created by Harshitha on 11/23/15.
//  Copyright (c) 2015 GSS Software. All rights reserved.
//

#import "LogTextViewController.h"

@interface LogTextViewController ()

@property (strong, nonatomic) IBOutlet UITextView *logTextView;
@property (strong, nonatomic) NSString *logTextString;
@property (strong, nonatomic) NSString *logFileName;

@end

@implementation LogTextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil forLogFile:(NSString*)logFile_name withLogText:(NSString*)logtext
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.logTextString = logtext;
        self.logFileName = logFile_name;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.title            = [NSString stringWithFormat:@"%@",self.logFileName];
    self.logTextView.text = self.logTextString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
