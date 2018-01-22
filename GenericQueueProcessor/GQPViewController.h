//
//  GQPViewController.h
//  GenericQueueProcessor
//
//  Created by Riyas Hassan on 29/10/14.
//  Copyright (c) 2014 GSS Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQPViewController : UIViewController


-(void)fetchNewDataWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
//- (void)doSomeStuff:(NSTimer*)timer;

- (void)initializeView;

@property (weak, nonatomic) IBOutlet UITableView *queueTable;

@end
