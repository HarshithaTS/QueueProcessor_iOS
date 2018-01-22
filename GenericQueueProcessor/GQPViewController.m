//
//  GQPViewController.m
//  GenericQueueProcessor
//
//  Created by Riyas Hassan on 29/10/14.
//  Copyright (c) 2014 GSS Software. All rights reserved.
//

#import "GQPViewController.h"
#import "Reachability.h"
#import "GQPMainTableViewCell.h"
#import "QueuedProcess.h"
#import "GQPQueueProcessor.h"
#import "LogViewController.h"
#import "GQPDetailViewController.h"

@interface GQPViewController ()<NSURLConnectionDataDelegate>
{
    int i;
}

// Original code
//@property (weak, nonatomic) IBOutlet UITableView *queueLogTable;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

// ***** Added by Harshitha *****
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)indexChanged:(UISegmentedControl *)sender;
@property (strong, nonatomic) IBOutlet UIView *tableHeader;
@property (strong, nonatomic) IBOutlet UIView *tableHeader_others;
// ***** Added by Harshitha ends here *****

@end

@implementation GQPViewController

// ***** Added by Harshitha *****
BOOL allStatus_tableDisplayed;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        
    }
    return self;
}
// ***** Added by Harshitha ends here *****

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"Queue Processor";
    if ([[[UIDevice currentDevice ] systemVersion ] floatValue] >= 7.0)
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    i = 0;
    
// ***** Added by Harshitha starts here *****
    CGRect frame= self.segmentedControl.frame;
    [self.segmentedControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 36)];
    
    if (IS_IPAD) {
        [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"STHeitiSC-Medium" size:18.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    }
    else {
        [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"STHeitiSC-Medium" size:12.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    }
    
    [[QPLogs sharedInstance] addSwipeGestureRecognizerForTarget:self withSelctor:@selector(loadLogView:) forDirection:UISwipeGestureRecognizerDirectionLeft];
    
// ***** Added by Harshitha ends here *****
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];

// Original code
//    [self initializeVariables];
 
// Modified by Harshitha
//    [self initializeView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initializeView) name:@"RefreshQueueTableView" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[GQPQueueProcessor sharedInstance] saveDataToQueueDBFromKeyChain];
    [self initializeView];
    
// Original code
//    [self getDataFromDBAndFillDatasource];
    
}

// Original code
//- (void)initializeVariables
//{
//    [self getDataFromDBAndFillDatasource];
//}

// ***** Added by Harshitha starts here *****
- (void)initializeView
{
    
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        [self.tableHeader setHidden:NO];
        [self.tableHeader_others setHidden:YES];
        allStatus_tableDisplayed = YES;
    }
    else
    {
        [self.tableHeader setHidden:YES];
        [self.tableHeader_others setHidden:NO];
        allStatus_tableDisplayed = NO;
    }
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"QueuedProcess" inManagedObjectContext:context]];
    
    NSPredicate *predicate;
    
    switch (self.segmentedControl.selectedSegmentIndex)
        {
            case 0: break;
            case 1: predicate = [NSPredicate predicateWithFormat:@"status = %@",@"Completed"];
                break;
            case 2: predicate = [NSPredicate predicateWithFormat:@"status = %@",@"Processing"];
                break;
            case 3: predicate = [NSPredicate predicateWithFormat:@"status = %@",@"Error"];
                break;
//            case 3: predicate = [NSPredicate predicateWithFormat:@"status != %@ AND status != %@ AND status != %@",@"Completed",@"Processing",@"Error"];
                break;
        }
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    self.dataSourceArray = (NSMutableArray*)[context executeFetchRequest:request error:&error];
    
    [self.queueTable reloadData];
}
// ***** Added by Harshitha ends here *****

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchNewDataWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{

    completionHandler(UIBackgroundFetchResultNoData);
    
}


- (void)reachabilityDidChange:(NSNotification *)notification {
    Reachability *reachability = (Reachability *)[notification object];
    
    if ([reachability isReachable])
    {
        NSLog(@"Reachable");
        [[GQPQueueProcessor sharedInstance] getDataFormKeyChainAndProcess];
    }
    else
    {
        NSLog(@"Unreachable");
    }
}

// ***** Original code *****
/*
- (void)getDataFromDBAndFillDatasource
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"QueuedProcess" inManagedObjectContext:context]];
    
//    NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"status != %@ OR status = NULL",@"Completed" ];// OR status != %@,@"Processing"];
//    [request setPredicate:predicate];
//    
    
    NSError *error                  = nil;
    self.dataSourceArray            = (NSMutableArray*)[context executeFetchRequest:request error:&error];
    
    [self.queueLogTable reloadData];
    
}
*/
 
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


#pragma mark TableView Delegates and datasources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [self.dataSourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
// Original code
//    if (tableView == self.queueLogTable)

// Modified by Harshitha
    if (tableView == self.queueTable)
    {
        static NSString * cellIdentifier = @"GQPMainTableViewCell";
        
        GQPMainTableViewCell *cell = (GQPMainTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            NSArray * nibArray  = [[NSBundle mainBundle]loadNibNamed:@"GQPMainTableViewCell" owner:self options:nil];
            
// ***** Original code *****
//            cell                = [nibArray objectAtIndex:0];

// ***** Modified by Harshitha starts here *****
            if (IS_IPAD) {
                if (self.segmentedControl.selectedSegmentIndex == 0)
                {
                    cell                = (GQPMainTableViewCell *)[nibArray objectAtIndex:1];
                }
                else
                {
                    cell                = (GQPMainTableViewCell *)[nibArray objectAtIndex:0];
                }
            }
            else {
                cell                    = (GQPMainTableViewCell *)[nibArray objectAtIndex:2];
                
                cell.statusImageView.hidden = YES;
                if (self.segmentedControl.selectedSegmentIndex == 0) {
                    cell.statusImageView.hidden = NO;
                }
            }
            
        }
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
        
        NSArray * nibArray  = [[NSBundle mainBundle]loadNibNamed:@"GQPMainTableViewCell" owner:self options:nil];
        if (IS_IPAD) {
            if (allStatus_tableDisplayed)
            {
                cell                = (GQPMainTableViewCell *)[nibArray objectAtIndex:1];
            }
            else
            {
                cell                = (GQPMainTableViewCell *)[nibArray objectAtIndex:0];
            }
        }
        else {
            cell                    = (GQPMainTableViewCell *)[nibArray objectAtIndex:2];
        }
        
        cell.backgroundView     = nil;
        cell.backgroundColor    = [UIColor clearColor];
// ***** Modified by Harshitha ends here *****
        
        QueuedProcess * queueData       = [self.dataSourceArray objectAtIndex:indexPath.row];
        
        cell.backgroundColor            = [UIColor clearColor];
// Original code
//        cell.statusLabel.backgroundColor= [UIColor greenColor];
        
        cell.appLabel.text              = queueData.appName;
        
        if (IS_IPAD)
            cell.referenceIdLabel.text      = queueData.referenceID;
        else
            cell.referenceIdLabel.text      = [NSString stringWithFormat:@"Doc# %@",queueData.referenceID];
        
        cell.subApplicationLabel.text   = queueData.subApplication;
        
//        cell.dateAdded.text             = queueData.queueDate;
        cell.dateAdded.text             = queueData.processStartTime;
        
        cell.objectTypeLabel.text       = queueData.objectType;
        
/*        if (queueData.status.length <= 0)
            cell.statusLabel.text = @"Not Started";
        else
            cell.statusLabel.text           = queueData.status;
*/
        cell.statusImageView.image = [UIImage imageNamed:[self statusImageForstatus:queueData.status]];
        
        return cell;
    }
    
    return nil;
}

// ***** Added by Harshitha starts here *****
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2)
    {
        cell.backgroundColor =  [UIColor colorWithRed:167.0/255 green:193.0/255 blue:160.0/255 alpha:1.0];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QueuedProcess *queueData = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    GQPDetailViewController *detailViewObj;
    
    if (IS_IPAD)
        detailViewObj = [[GQPDetailViewController alloc]initWithNibName:@"GQPDetailViewController" bundle:nil withQueuedObjectDetails:(QueuedProcess*)queueData];
    else
        detailViewObj = [[GQPDetailViewController alloc]initWithNibName:@"GQPDetailViewController_iPhone" bundle:nil withQueuedObjectDetails:(QueuedProcess*)queueData];

    
    [self.navigationController pushViewController:detailViewObj animated:YES];
}

- (IBAction)indexChanged:(UISegmentedControl *)sender {
  
    [self initializeView];
}

- (NSString *) statusImageForstatus:(NSString *)statusStr
{
    NSString *statusImageName = @"";
    if ([statusStr isEqualToString:@"Completed"])
        statusImageName = @"LIGHT_GREEN.png";
    
    else if ([statusStr isEqualToString:@"Error"])
        statusImageName = @"LIGHT_RED.png";
    
    else if ([statusStr isEqualToString:@"Processing"])
        statusImageName = @"LIGHT_ORANGE.png";
    
    return statusImageName;
}

- (void) loadLogView:(id)sender
{
    LogViewController *logView;
    if (IS_IPAD)
        logView = [[LogViewController alloc]initWithNibName:@"LogViewController" bundle:nil];
    else
        logView = [[LogViewController alloc]initWithNibName:@"LogViewController_iPhone" bundle:nil];
        
    [self.navigationController pushViewController:logView animated:YES];
//    [self presentViewController:logView animated:YES completion:nil];
}

// ***** Added by Harshitha ends here *****

@end
