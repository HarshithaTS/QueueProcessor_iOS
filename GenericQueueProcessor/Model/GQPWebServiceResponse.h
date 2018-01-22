//
//  GQPWebServiceResponse.h
//  GenericQueueProcessor
//
//  Created by Riyas Hassan on 05/11/14.
//  Copyright (c) 2014 GSS Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GQPWebServiceResponse : NSObject

@property (nonatomic, strong) NSString * referenceID;
@property (nonatomic, strong) NSString * action;
@property (nonatomic, strong) NSString * responseMsg;
@property (nonatomic, strong) NSMutableArray * responseArray;
@property (nonatomic, strong) NSString * errorResponseMessage;

@end
