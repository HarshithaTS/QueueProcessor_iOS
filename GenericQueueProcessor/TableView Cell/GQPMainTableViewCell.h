//
//  GQPMainTableViewCell.h
//  GSSQueueProcessorUI
//
//  Created by Riyas Hassan on 27/08/14.
//  Copyright (c) 2014 GSS Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQPMainTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *appLabel;
@property (strong, nonatomic) IBOutlet UILabel *referenceIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *subApplicationLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateAdded;
@property (strong, nonatomic) IBOutlet UILabel *objectTypeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;


@end
