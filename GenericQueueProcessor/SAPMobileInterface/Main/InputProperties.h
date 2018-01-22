//
//  InputProperties.h
//  GssServiceproBeta
//
//  Created by GSS Mysore on 7/7/14.
//  Copyright (c) 2014 GSS Mysore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"


@interface InputProperties : NSObject
{
    
   
    
}
//SOAP Variables

@property(nonatomic, retain) NSString *objectType;
@property(nonatomic, retain) NSString *subApp;






@property(nonatomic, retain) NSString *WebServiceUrl;
@property(nonatomic, retain) NSString *SoapDeviceIdentificationNumber;
@property(nonatomic, retain) NSString *CustomGCID;

//SOAP Request
@property(nonatomic, retain) NSString *ApplicationName;
@property (nonatomic, retain) NSString *NotationString;
@property(nonatomic, retain) NSString *ApplicationVersion;
@property(nonatomic, retain) NSString *ApplicationResponseType;
@property(nonatomic, retain) NSString *ApplicationEventAPI;
@property(nonatomic, retain) NSMutableArray *InputDataArray;
@property(nonatomic, retain) NSString *APP_UIC_Event_API;
@property(nonatomic, retain) NSString *RefernceID;

//SOAP Request Extension
@property(nonatomic, retain) NSString *InputDataArrayStg;


//Database
@property(nonatomic, retain) NSString * TargetDatabase;


//SAP XML request string
@property(nonatomic, retain) NSString *SAP_Request_String;

//SAP XML response pre-parsing
@property(nonatomic, retain) CXMLDocument *SAP_Response_Data;

// Variable added by Harshitha to store responsedata
@property(nonatomic, retain)NSString *responseArrayStr;

//SOAP ERROR MESSAGE
@property (nonatomic,retain) NSString *Error_Type;


    + (id)sharedInstance;
@end
