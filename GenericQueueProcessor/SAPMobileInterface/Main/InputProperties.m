//
//  InputProperties.m
//  GssServiceproBeta
//
//  Created by GSS Mysore on 7/7/14.
//  Copyright (c) 2014 GSS Mysore. All rights reserved.
//

#import "InputProperties.h"

@implementation InputProperties


@synthesize objectType;
@synthesize subApp;

//Divice Information

@synthesize WebServiceUrl;
@synthesize SoapDeviceIdentificationNumber;
@synthesize CustomGCID;


//SOAP
@synthesize ApplicationName;
@synthesize NotationString;
@synthesize ApplicationVersion;
@synthesize ApplicationResponseType;
@synthesize ApplicationEventAPI;
@synthesize InputDataArray;
@synthesize APP_UIC_Event_API;
@synthesize TargetDatabase;
@synthesize RefernceID;


//Input Array String
@synthesize InputDataArrayStg;

//Webservice xml Request
@synthesize SAP_Request_String;

//WEBSERVICE XML RESPONSE
@synthesize SAP_Response_Data;

@synthesize responseArrayStr;

//SOAP ERROR RESPONSE
@synthesize Error_Type;


static InputProperties *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (InputProperties *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        
        objectType = [[NSString alloc] init];
        subApp = [[NSString alloc] init];
        
        ApplicationName = [[NSString alloc] init];
        NotationString= [[NSString alloc] init];
        ApplicationVersion= [[NSString alloc] init];
        ApplicationResponseType= [[NSString alloc] init];
        ApplicationEventAPI= [[NSString alloc] init];
        InputDataArray= [[NSMutableArray alloc] init];
        
        WebServiceUrl = [[NSString alloc] init];
        SoapDeviceIdentificationNumber =[[NSString alloc] init];
        CustomGCID = [[NSString alloc] init];
        
        APP_UIC_Event_API = [[NSString alloc] init];
        
        TargetDatabase = [[NSString alloc] init];
        
        InputDataArrayStg = [[NSString alloc] init];
        
        responseArrayStr = [[NSString alloc]init];
        
    }
    
    return self;
}
@end
