//
//  GQPDetailViewController.m
//  GenericQueueProcessor
//
//  Created by Harshitha on 11/27/15.
//  Copyright (c) 2015 GSS Software. All rights reserved.
//

#import "GQPDetailViewController.h"
#import <MessageUI/MessageUI.h>

@interface GQPDetailViewController () <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

@end

@implementation GQPDetailViewController

QueuedProcess *queueObj;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withQueuedObjectDetails:(QueuedProcess*)queuedObjectDetail
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        queueObj = queuedObjectDetail;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setEmailIconForRightBarbutton];
    
    [self initializeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeView
{
    self.detailTextView.text = [NSString stringWithFormat:@"Application Name : %@\nReference ID : %@\nSub Application : %@\nStart time : %@\nObject type : %@\nRequest : %@\nStatus : %@\nProcess Count : %@",queueObj.appName,queueObj.referenceID,queueObj.subApplication,queueObj.processStartTime,queueObj.objectType,queueObj.inputDataArrayString,queueObj.status,queueObj.processCount];
}

- (void) setEmailIconForRightBarbutton
{
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBarBtn setImage:[UIImage imageNamed:@"E-mail"] forState:UIControlStateNormal];
    
    rightBarBtn.frame = CGRectMake(0, 0, 40, 40);
    
    rightBarBtn.showsTouchWhenHighlighted=YES;
    
    [rightBarBtn addTarget:self action:@selector(sendQueuedItemDetailMail) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    
    self.navigationItem.rightBarButtonItem  = rightBarButton;
}

- (void) sendQueuedItemDetailMail
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"A mail from GSS QueueProcessor User"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"Gss.Mobile@globalsoft-solutions.com", nil];
        [mailer setToRecipients:toRecipients];
        
        NSString *emailBody = self.detailTextView.text;
        
        [mailer setMessageBody:emailBody isHTML:NO];
        
        [self presentViewController:mailer animated:YES completion:nil];
        
    }
    else
    {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Failure" message:@"Your device doesn't support the composer sheet" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
