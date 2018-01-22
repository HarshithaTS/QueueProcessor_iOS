//
//  GQPDetailViewController.h
//  GenericQueueProcessor
//
//  Created by Harshitha on 11/27/15.
//  Copyright (c) 2015 GSS Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueuedProcess.h"

@interface GQPDetailViewController : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withQueuedObjectDetails:(QueuedProcess*)queuedObjectDetail;

@end
