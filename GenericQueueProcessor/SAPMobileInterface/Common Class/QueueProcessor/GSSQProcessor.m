//
//  GSSQProcessor.m
//  GssServiceproBeta
//
//  Created by GSS Mysore on 8/11/14.
//  Copyright (c) 2014 GSS Mysore. All rights reserved.
//

#import "GSSQProcessor.h"

#import "InputProperties.h"



@implementation GSSQProcessor



NSString *const QdbName = @"db_queueprocessor";

@synthesize attemptCnt;
@synthesize periority;
@synthesize refID;
@synthesize qID;
@synthesize logID;
@synthesize qStatus;



@synthesize errorDesc,errorType,qPReturnData;

-(NSString *) getCurrentDateandTimeStamp {
    //Get Current Date and time stamp
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [DateFormatter stringFromDate:[NSDate date]];
}


-(BOOL) putDataIntoQerrortbl{
    
    BOOL rtnResult;
    objServiceMngtCls = [[GssMobileConsoleiOS alloc] init];
    objServiceMngtCls.CRMdelegate = self;
    
    InputProperties *objInputProperties = [InputProperties sharedInstance];
    
    //Get Current Date and time stamp
 /*   NSDate* mDate = [NSDate date];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd hh:MM"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *errDate =[formatter stringFromDate:mDate];*/
    NSString *errDate = [self getCurrentDateandTimeStamp];
    
    
        NSString *sqlQuery = [NSString stringWithFormat:@"INSERT INTO TBL_ERRORLIST (apprefid,appname,apiname,errtype,errdesc,errdate,status) VALUES ('%@','%@','%@','%@','%@','%@',1)",
                              self.refID,
                              objInputProperties.ApplicationName,
                              objInputProperties.ApplicationEventAPI,
                              self.errorType,
                              self.errorDesc,
                              errDate];
        
        //NSLog(@"Sql Query %@", sqlQuery);
        
        //Insert data Into table
        objServiceMngtCls.TargetDatabase = QdbName;
        objServiceMngtCls.qryString = sqlQuery;
        rtnResult = [objServiceMngtCls excuteSqliteQryString];
        

    return rtnResult;
    
}

-(BOOL) putDataIntoQtable{
    
    BOOL rtnResult;
    objServiceMngtCls = [[GssMobileConsoleiOS alloc] init];
    objServiceMngtCls.CRMdelegate = self;

    InputProperties *objInputProperties = [InputProperties sharedInstance];
    

    if ([objInputProperties.RefernceID length] >0)
    {
     //   CREATE TABLE IF NOT EXISTS QP0610114_2456 (ID INTEGER PRIMARY KEY, applicationname TEXT, objecttype TEXT,subapplication TEXT,subapplicationversion TEXT, applicationeventapi TEXT, inputdataarraystring TEXT, referenceid TEXT, targetDatabase TEXT, deviceid TEXT,periority TEXT,status TEXT,keychainupdate NUMERIC, starttime TEXT, endtime TEXT,  attempt NUMERIC, created TEXT);

        NSString *sqlQuery = [NSString stringWithFormat:@"INSERT INTO QP0610114_2456 (applicationname, objecttype,subapplication,subapplicationversion, applicationeventapi, inputdataarraystring, referenceid, targetDatabase, deviceid,periority,status,keychainupdate,starttime, endtime,  attempt, created) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@',1,0,0,'','',0,'%@')",
                              objInputProperties.ApplicationName,
                              objInputProperties.objectType,
                              objInputProperties.subApp,
                              objInputProperties.ApplicationVersion,
                              objInputProperties.ApplicationEventAPI,
                              objInputProperties.InputDataArrayStg,
                              objInputProperties.RefernceID,
                              objInputProperties.TargetDatabase,
                              objInputProperties.CustomGCID,
                              [self getCurrentDateandTimeStamp]];
        
        //Insert data Into table
        objServiceMngtCls.TargetDatabase = QdbName;
        objServiceMngtCls.qryString = sqlQuery;
        rtnResult = [objServiceMngtCls excuteSqliteQryString];
        NSLog(@"Q Insert Query %@",sqlQuery);
        NSLog(@"push data into Q table... RefID:%@  success:%hhd", objInputProperties.RefernceID, rtnResult);
        
        
        
        [self saveQPDatInKeychain];
    }
    else
    {
        rtnResult = YES;
      
    }
    return rtnResult;
    
}
-(BOOL) updateQdata:(NSString *) mperiority count:(NSString *)mcount QueueID:(NSString *) mQID{
    
     BOOL rtnResult;
    
    //Get Current Date and time stamp
    NSString *errDate = [self getCurrentDateandTimeStamp];
    
    objServiceMngtCls = [[GssMobileConsoleiOS alloc] init];
    objServiceMngtCls.CRMdelegate = self;
    //Retrieving all service list data.
    objServiceMngtCls.TargetDatabase = QdbName;
    objServiceMngtCls.qryString = [NSString stringWithFormat:@"UPDATE QP0610114_2456 SET periority = %@,attempt= %@,starttime='%@' WHERE ID = %@",mperiority,mcount,errDate,mQID];
    
    NSLog(@"Update query %@", objServiceMngtCls.qryString);
    
    rtnResult = [objServiceMngtCls excuteSqliteQryString];
    //************************************************************
    //********************Update KeyChain************************
    //Update Queue Status into KeyChain
    [self saveQPDatInKeychain];
    //************************************************************
    //************************************************************
    
    return rtnResult;

    
}
-(BOOL) updateQdata:(NSString *) mstatus QueueID:(NSString *) mQID{
    
    BOOL rtnResult;
    
   NSString *errDate = [self getCurrentDateandTimeStamp];
    
    objServiceMngtCls = [[GssMobileConsoleiOS alloc] init];
    objServiceMngtCls.CRMdelegate = self;
    //Retrieving all service list data.
    objServiceMngtCls.TargetDatabase = QdbName;
    objServiceMngtCls.qryString = [NSString stringWithFormat:@"UPDATE QP0610114_2456 SET status = %@,endtime='%@' WHERE ID = %@",mstatus,errDate,mQID];
    NSLog(@"Update query %@", objServiceMngtCls.qryString);

    rtnResult = [objServiceMngtCls excuteSqliteQryString];
    
    [self saveQPDatInKeychain];
    
    return rtnResult;
    
    
}

-(BOOL) deleteQdata:(NSString *) mQID {
    
    BOOL rtnResult;
    
    objServiceMngtCls = [[GssMobileConsoleiOS alloc] init];
    objServiceMngtCls.CRMdelegate = self;
    //Retrieving all service list data.
    objServiceMngtCls.TargetDatabase = QdbName;
    objServiceMngtCls.qryString = [NSString stringWithFormat:@"DELETE FROM QP0610114_2456 WHERE ID=%@",mQID];
    rtnResult = [objServiceMngtCls excuteSqliteQryString];
    
    [self saveQPDatInKeychain];
    
    return rtnResult;
}


-(int) insertIntoLogTable:(NSString *) mrefID queueid:(NSString *) mqid description:(NSString *) desc{
  

    NSString *logDate = [self getCurrentDateandTimeStamp];
    
    NSLog(@"Current date stamp: %@", logDate);
    //CREATE TABLE QPLOG061014_2456 (qid TEXT, description TEXT, date TEXT, refid TEXT, id INTEGER PRIMARY KEY);

    
    NSString *sqlQuery = [NSString stringWithFormat:@"INSERT INTO tbl_log (qid,description,date,refid) VALUES ('%@','%@','%@','%@')",
                          mqid,
                          desc,
                          logDate,
                          mrefID];
    
    NSLog(@"Insert LOG Q reference id:%@", mrefID);
    NSLog(@"Log Insert Query %@", sqlQuery);

    //Insert data Into table
    objServiceMngtCls.TargetDatabase = QdbName;
    objServiceMngtCls.qryString = sqlQuery;
    return [objServiceMngtCls insertSqliteQryString];

}

-(BOOL) updateLogTable:(int) mlogID description:(NSString *) desc{
    
    
    NSString *logDate = [self getCurrentDateandTimeStamp];
    
    NSString *sqlQuery = [NSString stringWithFormat:@"UPDATE tbl_log  SET description = '%@', date = '%@' WHERE ID=%d",desc,logDate,mlogID];
    
    NSLog(@"update log table:%d", self.logID);
    
    //Insert data Into table
    objServiceMngtCls.TargetDatabase = QdbName;
    objServiceMngtCls.qryString = sqlQuery;
    return [objServiceMngtCls excuteSqliteQryString];
    
}


-(NSMutableArray *) getNewQdata
{
   
    objServiceMngtCls = [[GssMobileConsoleiOS alloc] init];
    objServiceMngtCls.CRMdelegate = self;
    //Retrieving all service list data.
    objServiceMngtCls.TargetDatabase = QdbName;
    objServiceMngtCls.qryString = @"SELECT * FROM QP0610114_2456 WHERE attempt = 0 and status = '0' ORDER BY periority,attempt";
    return [objServiceMngtCls fetchDataFrmSqlite];
}

-(NSMutableArray *) getPendingQdata
{
    
    objServiceMngtCls = [[GssMobileConsoleiOS alloc] init];
    objServiceMngtCls.CRMdelegate = self;
    //Retrieving all service list data.
    objServiceMngtCls.TargetDatabase = QdbName;
    objServiceMngtCls.qryString = @"SELECT * FROM QP0610114_2456 WHERE attempt > 0 and status = '2' ORDER BY periority,attempt";
    return [objServiceMngtCls fetchDataFrmSqlite];
}


-(NSMutableArray *) getQPData:(NSString *)status QattemptCount:(int*)attemptcnt
{
    
    objServiceMngtCls = [[GssMobileConsoleiOS alloc] init];
    objServiceMngtCls.CRMdelegate = self;
    //Retrieving all service list data.
    objServiceMngtCls.TargetDatabase = QdbName;
    objServiceMngtCls.qryString = @"";//[NSString stringWithFormat:@"SELECT * FROM tbl_QProcessor WHERE status='%@' and count=%d",status,attemptcnt];
    return [objServiceMngtCls fetchDataFrmSqlite];
}


-(BOOL) checkQPData:(NSString *) mAppName ObjectType:(NSString *)mObjType SubApplication:(NSString *)mSubApp ReferenceID:(NSString *) mrefID
{
    objServiceMngtCls = [[GssMobileConsoleiOS alloc] init];
    objServiceMngtCls.CRMdelegate = self;
    //Retrieving all service list data.
    objServiceMngtCls.TargetDatabase = QdbName;
    objServiceMngtCls.qryString = [NSString stringWithFormat:@"SELECT * FROM QP0610114_2456 WHERE applicationname = '%@' and objecttype = '%@' and subapplication = '%@' and refernceid = '%@'",mAppName,mObjType,mSubApp,mrefID];
    self.qPReturnData = [objServiceMngtCls fetchDataFrmSqlite];
    if ([self.qPReturnData count] >0){
        NSDictionary *tempDic;
        //MOVE TEMP DICTIONARY
        tempDic = [self.qPReturnData objectAtIndex:0];
        self.qID = [tempDic objectForKey:@"ID"];
        //QUEUE DATA FOUND AND DELETED
        [self deleteQdata:self.qID];
        NSLog(@"Delete Queue Data.. Ref ID: %@ ",self.qID);
        return TRUE;
    }
    else
    {
        NSLog(@"No Record Found in Queue for this Record");
        return FALSE;
    }
}
-(BOOL) checkLastExecution:(NSMutableDictionary *) mQueueData{
    
    NSString *startDate = [mQueueData objectForKey:@"starttime"];
    NSString *endDate = [mQueueData objectForKey:@"endtime"];
    
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    // Set the date format according to your needs
    //[df setDateFormat:@"MM/dd/YYYY hh:mm a"]; //for 12 hour format
    [df setDateFormat:@"YYYY-MM-dd HH:mm:ss "];  // for 24 hour format
    NSDate *date1 = [df dateFromString:startDate];
    NSDate *date2 = [df dateFromString:endDate];
    
    NSLog(@"%@  %@ is the time difference",date2,date1);

    
    NSLog(@"%f is the time difference",[date2 timeIntervalSinceDate:date1]);
    
    
    NSLog(@"Start date %@   end date %@", startDate, endDate);
    if ([date2 timeIntervalSinceDate:date1] > 600)
        return TRUE;
    else
        return FALSE;
}

//=========CALL WEBSERVICE

-(void) initialQueueDataforWebserviceCall{
    
    
    //UPDATE QUEUE RUNNAIN STATUS
    self.qStatus = @"RUNNING";
    //END

    //GET NEW AND PENDING QUEUE DATA FOR SOAP PROCESS
    self.qPReturnData = [self getNewQdata];
    
    //CHECK ANY DATA AVAILABLE IN QUEUE TABLE
    if ([self.qPReturnData count] >0) {
        //CALL WBSERVICE
        [self startProcessQueuedData];
    }
    else
    {
        //GET PENDING QUEUE DATA FOR PROCESSES
            self.qPReturnData = [self getPendingQdata];
            //CHECK ANY DATA AVAILABLE IN QUEUE TABLE
            if ([self.qPReturnData count] >0) {
                //CHECK LAST EXECUTION TIME
                if([self checkLastExecution:[self.qPReturnData objectAtIndex:0]])
                    //CALL WBSERVICE
                    [self startProcessQueuedData];
            }
        }

    }

-(void) startProcessQueuedData{
    
    //UPDATED ON 07/10/2014 BY SELVAN
    NSMutableArray *getInputArray = [[NSMutableArray alloc] init];
    objServiceMngtCls = [[GssMobileConsoleiOS alloc] init];
    objServiceMngtCls.CRMdelegate = self;
    
    
    NSDictionary *tempDic;

    //Read data from mutable array
    //if ([self.qPReturnData count] >0)
    
    {
        
        
        //Store it into temporary dictionary
        tempDic = [self.qPReturnData objectAtIndex:0];
        

        
        //************************************************************
        //GET VALUES INTO LOCAL VARIABLE
        self.refID = [tempDic objectForKey:@"referenceid"];
        self.attemptCnt = [tempDic objectForKey:@"attempt"];
        self.qID = [tempDic objectForKey:@"ID"];
        //************************************************************
        
        
         
        NSLog(@"Queue Processing Reference ID %@", self.refID);

        //****************************************************************************************************
        //UPDATE LOG TABLE ABOUT QUEUE PROCESS
        self.logID = [self insertIntoLogTable:self.refID queueid:self.qID description:@"STARTED"];
        //END
        //****************************************************************************************************
        
        //************************************************************************************************************************
        //UPDATE QUEUE TABLE PRIORITY, ATTEMPT COUNT AND START TIME
        [self updateQdata:@"2" count:[NSString stringWithFormat:@"%d",[self.attemptCnt integerValue]+1] QueueID:self.qID];
        //END
        //************************************************************************************************************************
        
        //Read values from dictionary and assign to soap property
        objServiceMngtCls.CustomGCID = [tempDic objectForKey:@"deviceid"];
        objServiceMngtCls.ApplicationName = [tempDic objectForKey:@"applicationname"];
        objServiceMngtCls.ApplicationVersion = [tempDic objectForKey:@"applicationversion"];
        objServiceMngtCls.ApplicationEventAPI = [tempDic objectForKey:@"applicationeventapi"];
        NSString *tempStr =  [tempDic objectForKey:@"inputdataarraystring"];
        
        objServiceMngtCls.InputDataArray =[self createMutableArray:[tempStr componentsSeparatedByString:@","]];
        
        objServiceMngtCls.TargetDatabase = [tempDic objectForKey:@"targetDatabase"];

        NSLog(@"eventapi:%@ ",objServiceMngtCls.ApplicationEventAPI);

        self.qStatus = @"WEBSERVICE";
        //************************************************************
        //************************************************************
        //CAll WEBSERVICE
//        [objServiceMngtCls callSOAPWebMethod];
        //************************************************************
        //************************************************************
        tempDic = nil;
    
    }
    
    
    
    getInputArray = nil;
    objServiceMngtCls = nil;
}

-(BOOL) checkLastExecutionTime {
    
    return TRUE;
}


- (NSMutableArray *)createMutableArray:(NSArray *)array
{
    return [array mutableCopy];
}

//================================================================================================================================
//MESSAGE SHOWING TO USER - START
//Delegate for Service Management

-(void)GssMobileConsoleiOS_Response_Message:(NSString *)msg_type andMsgDesc:(NSString *)message andFLD:(NSMutableArray *)FLD_VC {
    
    
//     NSLog(@"SAPCRMMobileAppConsole Return Message Type: %@",msg_type);
//     NSLog(@"SAPCRMMobileAppConsole Return Response Message: %@",message);
//     NSLog(@"SAPCRMMobileAppConsole Return Response Array: %@",FLD_VC);
//    
//    
//     NSLog(@"Ref id %@, count %@", self.refID, self.attemptCnt);
    
    self.qStatus = @"RESPONSE";
    //Handle Response
    if ([msg_type isEqualToString:@"Response"] && FLD_VC != nil)
    {
        NSArray *errResponseArray = [FLD_VC objectAtIndex:0];
        
        NSLog(@"SAP Response for Q: %@", errResponseArray);
        
        if ([[errResponseArray objectAtIndex:0] isEqualToString:@"S"]) {
            
            
            //****Delete completed Q data option stopped by selvan*****
            //Delete record from Queue table
            //[self deleteQdata:objServiceMngtCls.RefernceID];
            //NSLog(@"Delete Queue Data.. Ref ID: %@ ",self.refID);
            //*****end*************************************************
            
            NSLog(@"Queue id %@; log id %d",self.qID,self.logID);
            
            //INSERT DATA INTO LOG TABLE
            [self updateLogTable:self.logID description:@"COMPLETED"];
            
            //Update Q table for status
            [self updateQdata:@"1" QueueID:self.qID];
            
            
        }
        else
        {

            //UPDATE Q DATA
            if ([self.attemptCnt integerValue] < 3){
                NSLog(@"Updating Queue Data.. Q ID: %@ : attempt Count: %@",self.qID, self.attemptCnt );
                
                
                //INSERT DATA INTO LOG TABLE
                [self updateLogTable:self.logID description:@"WAITING"];
                
                //Update Q table for status
                [self updateQdata:@"2" QueueID:self.qID];
            }
            else
            {
                
                //read error type and description
                self.errorType = [errResponseArray objectAtIndex:0];
                errResponseArray = [FLD_VC objectAtIndex:3];
                self.errorDesc = [errResponseArray objectAtIndex:0];
 
                
                //Delete record from Queue table
                [self deleteQdata:self.qID];
                NSLog(@"Delete Queue Data.. Ref ID: %@ ",self.qID);
                
                //Push record to error table
                [self putDataIntoQerrortbl];
                NSLog(@"Add data to Error table Ref ID: %@ : attempt Count: %@",self.refID, self.attemptCnt );
                
                
                //INSERT DATA INTO LOG TABLE
                [self updateLogTable:self.logID description:@"ERROR"];
            }

     
            
        }
        
        self.qStatus = @"STOPPED";
        
        [self startProcessQueuedData];
        
    
        [self saveQPDatInKeychain];
    }
    
}

-(void)saveQPDatInKeychain
{
    
//    NSMutableArray * qpDataArray        = [self getNewQdata];
//    GSPKeyChainManager * keyChainManger = [GSPKeyChainManager new];
//    
//    for (NSDictionary * qpObject in qpDataArray) {
//    
//        [keyChainManger saveServiceTaskInKeyChain:qpObject forApplicationIdentifier:nil];
//    }

    
    
}

@end
