//
//  GssMobileConsoleiOS.m
//  GssMobileConsoleiOS
//
//  Created by GSS Mysore on 8/4/14.
//  Copyright (c) 2014 GSS Mysore. All rights reserved.
//

#import "GssMobileConsoleiOS.h"

#import "SingletonClass.h"
#import "ServiceDBHandler.h"
#import "TouchXMLPARSER.h"
#import "serviceSOAPHandler.h"
#import "CheckedNetwork.h"
#import "UIDevice+IdentifierAddition.h"
//#import "GCDThreads.h"
#import "MobileDBInterface.h"
#import "GSSQProcessor.h"
#import "GSSBackgroundTask.h"

#import "InputProperties.h"

@implementation GssMobileConsoleiOS
@synthesize CRMdelegate;

@synthesize WebR_Thread_block;

@synthesize appDatabases;


@synthesize gssWebServiceUrl;

//XML Parser
@synthesize DatabaseCreateFlag;
@synthesize Options;
@synthesize OtherString;
@synthesize xmlDocument;
//***************************************************************************************



//Database
@synthesize dbName;
@synthesize qryString;

//*****************************************************************************************


@synthesize qProgressPgLoaded;

//static dispatch_once_t onceToken;


// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    if (self) {
        
        objGCDThreads = [GCDThreads sharedInstance];
        
        objInputProperties = [InputProperties sharedInstance];
        
        qProgressPgLoaded = FALSE;
    }
    return self;
}
//*********************************************************************************************
//
//
//Plist Section
//
//
//
//*********************************************************************************************

-(void) readplistfile {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MobileSetup" ofType:@"plist"];
    MobileSetupDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    NSLog(@"%@",MobileSetupDictionary);
    //self.service_url = [dictionary objectForKey:@"SERVICEURL_PRD"];
    //self.service_url = [dictionary objectForKey:@"SERVICEURL_QA"];
    //self.buildName = [dictionary objectForKey:@"BUILDNAME"];
    
    self.gssWebServiceUrl =[MobileSetupDictionary objectForKey:@"ServiceURL"];
    //self.PackageName = [MobileSetupDictionary objectForKey:@"PackageName"];
    self.appDatabases = [MobileSetupDictionary objectForKey:@"Database"];
    NSLog(@"web service url %@", self.gssWebServiceUrl);
    
}
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//End Plist Section
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


//*********************************************************************************************
//
//
//Database Section
//
//
//*********************************************************************************************

-(void) createEmptyDatabase {
    
    //Create DBHandler Instants and assign value to its property
    ServiceDBHandler *objServiceDBHandler = [[ServiceDBHandler alloc] init];
    
    [self readplistfile];
    
    
    for (int i=0; i<[self.appDatabases count]; i++) {
        
        
        NSLog(@"Creating Database %@",[self.appDatabases objectAtIndex:i]);
        
        objInputProperties.TargetDatabase = [self.appDatabases objectAtIndex:i];
        BOOL returnValue =  [objServiceDBHandler createEditableCopyOfDatabaseIfNotThere];
        
        if (returnValue) {
            NSLog(@"Database Created: %@", objInputProperties.TargetDatabase);
        }
        
    }
    
    
    objServiceDBHandler= nil;
}

//Execute all sqlite query
-(BOOL)excuteSqliteQryString{
    //Create DBHandler Instants and assign value to its property
    ServiceDBHandler *objServiceDBHandler = [[ServiceDBHandler alloc] init];
    
    objInputProperties.TargetDatabase = self.TargetDatabase;
    objServiceDBHandler.qryString = self.qryString;
    return [objServiceDBHandler excuteSqliteQryString];
    
}

//insert query into sqlite
-(int)insertSqliteQryString{
    //Create DBHandler Instants and assign value to its property
    ServiceDBHandler *objServiceDBHandler = [[ServiceDBHandler alloc] init];
    
    objInputProperties.TargetDatabase = self.TargetDatabase;
    objServiceDBHandler.qryString = self.qryString;
    return [objServiceDBHandler insertDataIntoDB];
    
}

-(NSMutableArray *)fetchDataFrmSqlite {
    ServiceDBHandler *objServiceDBHandler = [[ServiceDBHandler alloc] init];
    NSMutableArray *resultMutArray = [[NSMutableArray alloc] init];

    objInputProperties.TargetDatabase = self.TargetDatabase;
    objServiceDBHandler.qryString = self.qryString;
    
    NSLog(@"target db: %@",objInputProperties.TargetDatabase);
    NSLog(@"query str: %@",objServiceDBHandler.qryString);
    
    
    return resultMutArray = [objServiceDBHandler fetchDataFrmSqlite];
    
}

-(void) verifyDatabaseTableEmpty {
    
    //Create DBHandler Instants and assign value to its property
    ServiceDBHandler *objServiceDBHandler = [[ServiceDBHandler alloc] init];
    
    //Declare Local array for tables
    NSMutableArray *sqliteMasterDBTables = [[NSMutableArray alloc] init];
    
    objInputProperties.TargetDatabase = self.TargetDatabase;
    objServiceDBHandler.qryString = @"SELECT name FROM SQLITE_MASTER WHERE type='table'";
    sqliteMasterDBTables = [objServiceDBHandler fetchDataFrmSqlite];
    //NSLog(@"List tables available %@",sqliteMasterDBTables);
    
    //Declare local dictionary for tables
    NSMutableArray *sqliteMasterDBTablesArray = [[NSMutableArray alloc] init];
    
    //Re-Group/Simplify sqliteMasterDBTables Array
    for (int cnt=0; cnt < [sqliteMasterDBTables count]; cnt++) {
        
        [sqliteMasterDBTablesArray addObject:[[sqliteMasterDBTables objectAtIndex:cnt] objectForKey:@"name"]];
    }
    
    NSLog(@"List tables available %@",sqliteMasterDBTablesArray);
    NSMutableArray *resultArray;
    int cntEmptyTbls =0;
    
    
    //Read Array
    for (int cnt=0; cnt < [sqliteMasterDBTablesArray count]; cnt++) {
        objInputProperties.TargetDatabase = self.TargetDatabase;
        objServiceDBHandler.qryString = [NSString stringWithFormat:@"SELECT * FROM '%@' WHERE 1",[sqliteMasterDBTablesArray objectAtIndex:cnt]];
        resultArray = [objServiceDBHandler fetchDataFrmSqlite];
        //Count Empty Tables
        if (resultArray == nil || [resultArray count] == 0)
            cntEmptyTbls = cntEmptyTbls + 1;
        
    }
    
    //Finalize FullSet/Delta Set here
    //if all tables are empty or no tables in DB then call Full Set otherwise delta set
    if (cntEmptyTbls >= [sqliteMasterDBTables count]) {
        self.ApplicationResponseType = @"[.]RESPONSE-TYPE[.]FULL-SETS";
    }
    else
        self.ApplicationResponseType = @"";
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//End Database Section
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


//*********************************************************************************************
//
//
//Webservice Section
//
//
//*********************************************************************************************
-(void) callSOAPWebMethodWithBlock:(void(^)(GQPWebServiceResponse * ))block {
    
    //SingletonClass* sharedSingleton = [SingletonClass sharedInstance];
    serviceSOAPHandler *objserviceSOAPHandler = [[serviceSOAPHandler alloc] init];
    TouchXMLPARSER *objTouchXMLPARSER = [[TouchXMLPARSER alloc] init];
    MobileDBInterface *objMobileDBInterface = [[MobileDBInterface alloc] init];
    
    
    //Read plist for webservice link
    [self readplistfile];
    
    //Check datbase table whether has empty or not to call full sets or delta sets
    [self verifyDatabaseTableEmpty];
    
    //Use singleton inputproperties
    objserviceSOAPHandler.whdlServiceURL = self.gssWebServiceUrl;
    objInputProperties.WebServiceUrl = self.gssWebServiceUrl;
    
    
    //USE WITH SOAP ENVALOP
    //Generate Own Device ID
    objInputProperties.CustomGCID = [[[UIDevice currentDevice] uniqueGlobalDeviceIdentifier] uppercaseString];
    //objInputProperties.CustomGCID = self.CustomGCID;
    objInputProperties.ApplicationName = self.ApplicationName;
    
    
    objInputProperties.SoapDeviceIdentificationNumber = [NSString stringWithFormat:@"DEVICE-ID:%@:DEVICE-TYPE:IOS:APPLICATION-ID:%@",objInputProperties.CustomGCID,objInputProperties.ApplicationName];
    
//    NSLog(@"customGCID %@", objInputProperties.CustomGCID);
//    NSLog(@"Application Name %@", objInputProperties.ApplicationName);
//    NSLog(@"Device ID %@",objInputProperties.SoapDeviceIdentificationNumber);
    
    objInputProperties.NotationString           = @"NOTATION:ZML:VERSION:0:DELIMITER:[.]";
    objInputProperties.ApplicationName          = self.ApplicationName;
    objInputProperties.ApplicationVersion       = self.ApplicationVersion;
    objInputProperties.ApplicationResponseType  = self.ApplicationResponseType;
    objInputProperties.ApplicationEventAPI      = self.ApplicationEventAPI;
    objInputProperties.InputDataArray           = self.InputDataArray;
    objInputProperties.RefernceID               = self.RefernceID;
  //  objInputProperties.PackageName              = self.PackageName;
    objInputProperties.objectType               = self.objectType;
    objInputProperties.subApp                   = self.subApp;
    
    NSLog(@"pro %@  %@",objInputProperties.ApplicationEventAPI,self.ApplicationEventAPI);
    //Convert input array as string to past it in clipboard
    objInputProperties.InputDataArrayStg = [self.InputDataArray componentsJoinedByString:@","];
  
    //Convert parsed data to sql query format to execute easly
    objInputProperties.TargetDatabase = self.TargetDatabase;
    
    NSLog(@"Target Database %@", objInputProperties.TargetDatabase);
    //End

    
    NSLog(@"is Internet Connection Available %hhd", [CheckedNetwork connectedToNetwork]);
   
    
    if ([CheckedNetwork connectedToNetwork]) {
        
        //dispatch_group_async(objGCDThreads.Task_Group,objGCDThreads.Concurrent_Queue_High,^{
        
        dispatch_async(objGCDThreads.Concurrent_Queue_Default_SAPCRM, ^{
            
            //SOPA CALL
            [objserviceSOAPHandler getResponseSAP];
            
            //XML PARSER (USING TouchXMLPARSER)
            NSMutableArray *postMssg = [objTouchXMLPARSER startParsingUsingData:objInputProperties.SAP_Response_Data nodesForXPath:@"//DpostMssg"];
            
//   Added by Harshitha to store responsedata
            objInputProperties.responseArrayStr = [NSString stringWithFormat:@"%@",objInputProperties.SAP_Response_Data];
            
            if (postMssg == nil) {
                
                postMssg = [objTouchXMLPARSER startParsingUsingData:objInputProperties.SAP_Response_Data nodesForXPath:@"//DpostOtpt"];
                
                [objMobileDBInterface createSQLQueryStringFromParsedData:postMssg];
                
            }
            else
            {
                
                
                GQPWebServiceResponse *response = [GQPWebServiceResponse new];
                response.action         = @"Response";
                response.responseMsg    = @"SAP Response Message";
                response.responseArray  = postMssg;
                response.referenceID    = self.RefernceID;
                block(response);
                
                [self.CRMdelegate GssMobileConsoleiOS_Response_Message:@"Response" andMsgDesc:@"SAP Response Message" andFLD:postMssg forRefernceID:self.RefernceID ];
                return ;
                
            }
            
            
            [self.CRMdelegate GssMobileConsoleiOS_Response_Message:@"Load" andMsgDesc:@"Loading Activity Indicator" andFLD:nil forRefernceID:self.RefernceID ];
            
            //NSLog(@"Parsed data:%@", postMssg);
            dispatch_group_async(objGCDThreads.Task_Group_SAPCRM, objGCDThreads.Main_Queue_SAPCRM, ^{
                //Stop Active Indicator
                GQPWebServiceResponse *response = [GQPWebServiceResponse new];
                response.action         = @"Response";
                response.responseMsg    = @"SAP Error Response";
                response.responseArray  = postMssg;
                
                if (!postMssg) {
                    response.errorResponseMessage = objInputProperties.Error_Type ;
                }

                response.referenceID    = self.RefernceID;
                block(response);
                [self.CRMdelegate GssMobileConsoleiOS_Response_Message:@"S" andMsgDesc:@"Stop Loading Activity Indicator" andFLD:postMssg forRefernceID:self.RefernceID ];
            });
            
            
            
        });
        
        
        dispatch_group_async(objGCDThreads.Task_Group_SAPCRM,objGCDThreads.Main_Queue_SAPCRM,^{
            [self.CRMdelegate GssMobileConsoleiOS_Response_Message:@"Load" andMsgDesc:@"Loading Activity Indicator" andFLD:nil forRefernceID:self.RefernceID ];
            
        });
        
        
    }
    else {
        
        //re-direct data to queue processor table for later process
        GSSQProcessor *objGSSQProcessor = [[GSSQProcessor alloc] init];
        if ([objGSSQProcessor putDataIntoQtable]) {
            
           GSSBackgroundTask * bgTask =[[GSSBackgroundTask alloc] init];
            
            //Star the timer
            [bgTask startBackgroundTasks:20 target:self selector:@selector(backgroundCallback:)];
            // where call back  is -(void) backgroundCallback:(id)info
            
            //Stop the task
            [bgTask stopBackgroundTask];
             
        }
        
        }
    
    objserviceSOAPHandler=nil ;
    objTouchXMLPARSER = nil ;
    
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//End Webservice Section
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-(void) backgroundCallback:(id)info{
    NSLog(@"call back code called");
    //Write code to check internect connectivity until it back
    GSSBackgroundTask * bgTask =[[GSSBackgroundTask alloc] init];
    
    
    if ([CheckedNetwork connectedToNetwork]) {
        
        GSSQProcessor *objGSSQProcessor = [[GSSQProcessor alloc] init];
        
        
        [objGSSQProcessor startProcessQueuedData];
        
        //Stop the task
        [bgTask stopBackgroundTask];

    }

}
@end
