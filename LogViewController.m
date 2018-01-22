//
//  LogViewController.m
//  GenericQueueProcessor
//
//  Created by Harshitha on 11/23/15.
//  Copyright (c) 2015 GSS Software. All rights reserved.
//

#import "LogViewController.h"
#import "LogTextViewController.h"
#import "GQPViewController.h"

@interface LogViewController ()

@property (strong, nonatomic) IBOutlet UITableView *logTable;
@property (strong, nonatomic) NSArray *logFilesArray;

@end

@implementation LogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.logFilesArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Logs";
    self.navigationItem.hidesBackButton = YES;

    [[QPLogs sharedInstance] addSwipeGestureRecognizerForTarget:self withSelctor:@selector(loadQPView:) forDirection:UISwipeGestureRecognizerDirectionRight];
    
    self.logFilesArray = [[QPLogs sharedInstance]fetchLogFileNames:@"QueueProcessorLogs"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.logTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.logFilesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"CellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];

    cell.textLabel.textColor = [UIColor colorWithRed:67.0/255 green:97.0/255 blue:40/255 alpha:1.0];
    cell.textLabel.text = [self.logFilesArray objectAtIndex:indexPath.row];
    if (IS_IPHONE)
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *logText = [[QPLogs sharedInstance]readStringFromLogFile:[self.logFilesArray objectAtIndex:indexPath.row] fromDirectory:@"QueueProcessorLogs"];
    
    LogTextViewController *logTextView;
    
    if (IS_IPAD)
        logTextView = [[LogTextViewController alloc]initWithNibName:@"LogTextViewController" bundle:nil forLogFile:[self.logFilesArray objectAtIndex:indexPath.row] withLogText:logText];
    else
        logTextView = [[LogTextViewController alloc]initWithNibName:@"LogTextViewController_iPhone" bundle:nil forLogFile:[self.logFilesArray objectAtIndex:indexPath.row] withLogText:logText];
    
    [self.navigationController pushViewController:logTextView animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2)
    {
        cell.backgroundColor =  [UIColor colorWithRed:167.0/255 green:193.0/255 blue:160.0/255 alpha:1.0];
    }
}

- (void) loadQPView:(id)sender
{
//    GQPViewController *QPView = [[GQPViewController alloc]initWithNibName:@"GQPViewController_iPad" bundle:nil];
//    [self.navigationController pushViewController:QPView animated:YES];
//    [self.navigationController popToViewController:QPView animated:YES];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
   
}

@end
