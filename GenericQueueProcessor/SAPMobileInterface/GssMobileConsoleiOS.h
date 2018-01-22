//
//  GssMobileConsoleiOS.h
//  GssMobileConsoleiOS
//
//  Created by GSS Mysore on 8/4/14.
//  Copyright (c) 2014 GSS Mysore. All rights reserved.
//

//Release Note 11/08/2014
//+++++++++++++++++++++++++
//Mobile interface name has been changed to GssMobileConsoleiOS from CRMMobileConsole
//Custom device id creater code and iOSMacros removed from console library. to be included in project side
//In Model class downloadsapwebservicedata method name changed to callGssMobileConsoleiOS
//Introduced new class InputProperties in console library to handle input parameters
//Empty database creation and serviceurl strings are moved to MobileSetup.plist
//Now ServiceSOAPHandler code simplified
//few more design pattern introuduced



#import <Foundation/Foundation.h>
#import "TouchXML.h"
#import "GCDThreads.h"
#import "InputProperties.h"

#import "GQPWebServiceResponse.h"


@protocol GssMobileConsoleiOSDelegate <NSObject>

-(void)GssMobileConsoleiOS_Response_Message:(NSString*)msg_type andMsgDesc :(NSString*)message andFLD:(NSMutableArray *) FLD_VC forRefernceID:(NSString*)refernceID;

@end

@interface GssMobileConsoleiOS : InputProperties
{
    
    GCDThreads *objGCDThreads;
    
    InputProperties *objInputProperties;
    
    id <GssMobileConsoleiOSDelegate> delegate;
    
    NSMutableDictionary *MobileSetupDictionary;
    
}
//Plist Variables
@property(nonatomic, retain)  NSArray *appDatabases;

//SOAP Variables
@property(nonatomic, retain) NSString *gssWebServiceUrl;


//XML PARSER Variables
@property(nonatomic, retain) NSString * DatabaseCreateFlag;
@property(nonatomic, retain) NSString * Options;
@property(nonatomic, retain) NSString * OtherString;

@property(nonatomic, retain) CXMLDocument *xmlDocument;


//Database Properties
@property(retain, nonatomic) NSString *dbName;
@property(retain, nonatomic) NSString *qryString;

@property (nonatomic,retain) NSLock *WebR_Thread_block;

@property (nonatomic,retain) id <GssMobileConsoleiOSDelegate> CRMdelegate;

@property (nonatomic, assign) BOOL qProgressPgLoaded;

-(void) readplistfile;


-(void) createEmptyDatabase;
-(NSMutableArray *)fetchDataFrmSqlite;
-(BOOL)excuteSqliteQryString;
-(int)insertSqliteQryString;

-(void) callSOAPWebMethodWithBlock:(void(^)(GQPWebServiceResponse * ))block;
@end
