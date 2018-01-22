//
//  serviceDBHandler.m
//  ServiceProUniverse
//
//  Created by GSS Mysore on 08/03/13.
//
//

#import "serviceDBHandler.h"
#import <sqlite3.h>

@implementation ServiceDBHandler


//@synthesize dbName
@synthesize qryString;//,createDBflag;

//Database Handler property
//@synthesize CreateDBFlag;
//@synthesize TargetDB;
@synthesize Optns;
@synthesize Others;


static ServiceDBHandler *sharedInstance = nil;
// Get the shared instance and create it if necessary.
+ (ServiceDBHandler *)sharedInstance {
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
        
        objInputProperties = [InputProperties sharedInstance];
        // Work your initialising magic here as you normally would
        //dbName = [[NSString alloc] init];
        qryString = [[NSString alloc] init];
       // createDBflag = FALSE;
        
    }
    
    return self;
}




//Returning the device document directory path..
-(NSString *)documentDirectoryServiceManagemenetDBPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentPath = [paths objectAtIndex:0];
	NSString *path = [documentPath stringByAppendingPathComponent:objInputProperties.TargetDatabase];
	return path;
}


//Checking the DB is present or not in device document folder, is not present copy the blank DB from application bundle to document folder...
//if  present then remove the older and copy new one and insert data from SAP..
//or you can do both...depends on the requirement..
-(BOOL)createEditableCopyOfDatabaseIfNeeded{
	
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:objInputProperties.TargetDatabase];
    BOOL success = [fileManager fileExistsAtPath:writableDBPath];
    
	if(success)
	{
		if([fileManager isDeletableFileAtPath:writableDBPath])
		{
			success = [fileManager removeItemAtPath:writableDBPath error:&error];
		}
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:objInputProperties.TargetDatabase];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
	}
	else
    {
        if(!success)
        {
            NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:objInputProperties.TargetDatabase];
            success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        }
        else
			NSLog(@"Database already exists");
        
        
	}
	return success;
}




-(BOOL)createEditableCopyOfDatabaseIfNotThere{
	
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:objInputProperties.TargetDatabase];
    BOOL success = [fileManager fileExistsAtPath:writableDBPath];
    
    if(!success)
    {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:objInputProperties.TargetDatabase];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    }
    else
        NSLog(@"Database already exists");
    
	return success;
}
//**********************************************************************************************************************************


-(BOOL)OpenSqliteDBConnection
{
    
    NSLog(@"Opening DB %@ ::::::::::::::::::::::::::::::::::::::::::::",objInputProperties.TargetDatabase);
    if(sqlite3_open([[self documentDirectoryServiceManagemenetDBPath] UTF8String],&database) == SQLITE_OK)
        return YES;
    else
        return NO;
    
}

//Close Database
-(void)closeSqliteDBConnection
{
    NSLog(@"Closing DB %@ :::::::::::::::::::::::::::::::::::::::::::::::::::",objInputProperties.TargetDatabase);
    sqlite3_close(database);
    database=Nil;
    
}

//Inserting data in Sqlite, for the task list array...
-(int)insertDataIntoDB{
	
	BOOL returnFlag = TRUE;
    int last_insert_row_ID=0;
    
    
	@try {
		
		//sqlite3_stmt *sqlStatement = nil;
        sqlStatement = nil;
		
		if(sqlStatement == nil)
		{
			//Open Database
            if ([self OpenSqliteDBConnection])
			{
				const char *sqlQuery= [[NSString stringWithFormat:@"%@",self.qryString] UTF8String];
				
				if(sqlite3_prepare_v2(database, sqlQuery, -1, &sqlStatement, NULL) != SQLITE_OK)
				{
					returnFlag = FALSE;
				}
			}
		}
        
		if(SQLITE_DONE != sqlite3_step(sqlStatement)) {
			returnFlag = FALSE;
            last_insert_row_ID = 0;
        }
		else {
			last_insert_row_ID = (int32_t)sqlite3_last_insert_rowid(database);
            
		}
        
		NSLog(@"Last Inserted ID: %d", last_insert_row_ID);
        
        
		sqlite3_reset(sqlStatement);
        sqlite3_finalize(sqlStatement);
        
        
        //Close opened database
        [self closeSqliteDBConnection];
		
	}
	@catch (NSException * e) {
		return 0;
	}
	
	return last_insert_row_ID;
}
//Execute all sqlite query
-(BOOL)excuteSqliteQryString{
    BOOL returnFlag = TRUE;
	
	@try {
		sqlite3_stmt *stmt = nil;
		
        
		if(stmt == nil)
		{
			//Open Database
            if ([self OpenSqliteDBConnection])

			{
				const char *sqlQuery = [self.qryString UTF8String];
				if(sqlite3_prepare_v2(database, sqlQuery, -1, &stmt, NULL) != SQLITE_OK)
                {
                    NSLog(@"Error while inserting data. '%s'", sqlite3_errmsg(database));
                    returnFlag = FALSE;
                }
					
			}
		}
		
		if(SQLITE_DONE != sqlite3_step(stmt))
			returnFlag = FALSE;
		
		sqlite3_reset(stmt);
        
        //Close opened database
        [self closeSqliteDBConnection];
        
        
	}
	@catch (NSException *e){
		NSLog(@"Exception=%@",e);
		returnFlag = FALSE;
	}
	
	
	return returnFlag;
}
// Get Data from sqlite database and store it into target array
//_qryStr = Query String
//_dbName = Database Name
//_desc = description about what data are you fetching like that...
//_optn = OptionfetchDataFrmSqlite

-(NSMutableArray *)fetchDataFrmSqlite{
    NSMutableArray *rsltAry = [[NSMutableArray alloc] init];
    
@try {
    //Open Database
    if ([self OpenSqliteDBConnection])

    {
        const char *sqlQuery = [self.qryString UTF8String];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, sqlQuery, -1, &stmt, NULL) == SQLITE_OK) {
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
                NSInteger _clmnCnt = 0;
                NSString *_clmnName=@"";
                NSString *_clmnText=@"";
                NSString *_srchStr=@"";
                
                _clmnCnt = sqlite3_column_count(stmt);
                
                for (int _rCnt=0; _rCnt < _clmnCnt; _rCnt++) {
                    
                    _clmnName = [NSString stringWithFormat:@"%s",(char*) sqlite3_column_name(stmt, _rCnt)];
                    _clmnText = [NSString stringWithFormat:@"%s",(char*) sqlite3_column_text(stmt, _rCnt)];
                    [tempDic setObject:_clmnText forKey:_clmnName];
                    
                    
                    //NSLog(@"%@ : %@ -> %@",_desc,_clmnName, _clmnText);
                    
                    
                    //Create search string
                    _srchStr = [_srchStr stringByAppendingString:_clmnText];
                    
                }
                
                //Inserting search string in to dictionary..
                [tempDic setObject:_srchStr forKey:@"SEARCH_STRING"];
                
                
                //NSLog(@"temp dic %@",tempDic);
                         
                [rsltAry addObject:tempDic];
                tempDic = nil;
            }
        }
        
        sqlite3_finalize(stmt);
       }
        //Close opened database
        [self closeSqliteDBConnection];
        
        
        
    return rsltAry;
  }
  @catch (NSException * e) {
		NSLog(@"Exception=%@",e);
}
    
}








//***************************************************************************************************************************************************
//########################################################################################
//########################################################################################
//Vanstock related database class
//########################################################################################
//########################################################################################
//Open  Database
-(BOOL)Open_Database:(NSString*)DBName
{
    
    NSLog(@"Opening Database ::::::::::::::::::::::::::::::::::::::::::::");
    if(sqlite3_open([[self documentDirectoryServiceManagemenetDBPath] UTF8String],&database) == SQLITE_OK)
        return YES;
    
    return NO;
    
}

//Close Database
-(void)Close_Database
{
    NSLog(@"Closing Database :::::::::::::::::::::::::::::::::::::::::::::::::::");
    sqlite3_close(database);
    database=Nil;
    
}


//Creating Table in LocalDatabase
-(BOOL)CreateTableInLocalDatabase:(NSString *)query
{
    
    char *error;
    
    if (sqlite3_exec(database,[query UTF8String], NULL, NULL, &error) == SQLITE_OK)
        return YES;
    
    return NO;
    
}


//Inserting data in LocalDatabase
-(BOOL)InsertTableInLocalDatabase:(NSString*)query
{
    
    BOOL returnFlag = TRUE;
    
    @try {
		
		sqlStatement = nil;
		
		if(sqlStatement == nil)
		{
			
            const char *sqlQuery= [[NSString stringWithFormat:@"%@",query] UTF8String];
            
            if(sqlite3_prepare_v2(database, sqlQuery, -1, &sqlStatement, NULL) != SQLITE_OK)
            {
                returnFlag = FALSE;
                
                NSLog(@"Error for Inserting  data in  Database::%s",sqlite3_errmsg(database));
                
                
            }
            
        }
        
        if(SQLITE_DONE != sqlite3_step(sqlStatement))
			returnFlag = FALSE;
		else
            sqlite3_last_insert_rowid(database);
        
        sqlite3_reset(sqlStatement);
        sqlite3_finalize(sqlStatement);
        
		
	}
	@catch (NSException * e) {
		returnFlag = FALSE;
	}
    
    
    return returnFlag;
    
    
}


//Updating data in Localdatabase
-(BOOL)UpdateTableInLocalDatabase:(NSString*)query
{
    BOOL returnFlag = TRUE;
    
    @try {
		
		sqlStatement = nil;
		
		if(sqlStatement == nil)
		{
			
            const char *sqlQuery= [[NSString stringWithFormat:@"%@",query] UTF8String];
            
            if(sqlite3_prepare_v2(database, sqlQuery, -1, &sqlStatement, NULL) != SQLITE_OK)
            {
                returnFlag = FALSE;
                NSLog(@"Error for Updating data in  Database::%s",sqlite3_errmsg(database));
                
            }
            
        }
        
        if (SQLITE_DONE != sqlite3_step(sqlStatement))
            NSAssert1(0, @"Error while Updating. '%s'", sqlite3_errmsg(database));
        
        sqlite3_reset(sqlStatement);
        sqlite3_finalize(sqlStatement);
        
    }
	@catch (NSException * e) {
		
        
        returnFlag = FALSE;
	}
    
    
    
    
    return returnFlag;
    
}


//Deleting data in Localdatabase
-(BOOL)DeleteTableInLocalDatabase:(NSString*)query
{
    
    BOOL returnFlag = TRUE;
    
    @try {
		
		sqlStatement = nil;
		
		if(sqlStatement == nil)
		{
			
            const char *sqlQuery= [[NSString stringWithFormat:@"%@",query] UTF8String];
            
            if(sqlite3_prepare_v2(database, sqlQuery, -1, &sqlStatement, NULL) != SQLITE_OK)
            {
                returnFlag = FALSE;
                NSLog(@"Error for deleting data in  Database::%s",sqlite3_errmsg(database));
                
            }
            
        }
        
        if (SQLITE_DONE != sqlite3_step(sqlStatement))
            NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
        
        sqlite3_reset(sqlStatement);
        sqlite3_finalize(sqlStatement);
        
    }
	@catch (NSException * e) {
		
        
        returnFlag = FALSE;
	}
    
    return returnFlag;
    
}

//Selecting Data from Database
-(NSMutableArray*)SelectTableInLocalDatabase:(NSString*)query
{
    
    NSMutableArray *TBRow_Data;
    NSMutableDictionary *Table_Row_FData;
    NSString *TBRow_N;
    NSString *TBRow_V;
    int flag;
    int Fcount;
    
    @try {
        
		const char *sqlQuery = [query UTF8String];
        sqlStatement=Nil;
        
        
        TBRow_Data = [[NSMutableArray alloc] init];
        
        
        if(sqlite3_prepare_v2(database, sqlQuery, -1, &sqlStatement, NULL) == SQLITE_OK) {
            
            flag=0;
            
            Fcount = sqlite3_column_count(sqlStatement);
            
            while (sqlite3_step(sqlStatement) == SQLITE_ROW) {
                
                Table_Row_FData = [[NSMutableDictionary alloc] init];
                
                flag=1;
                
                for (int i=0;i<Fcount;i++) {
                    
                    TBRow_N = [NSString stringWithFormat:@"%s",(char*) sqlite3_column_name(sqlStatement,i)];
                    TBRow_V = [NSString stringWithFormat:@"%s",(char*) sqlite3_column_text(sqlStatement,i)];
                    
                    
                    [Table_Row_FData setObject:TBRow_V forKey:TBRow_N];
                    
                    TBRow_N = Nil;
                    TBRow_V = Nil;
                    
                    
                }
                
                
                [TBRow_Data addObject:Table_Row_FData];
                Table_Row_FData=Nil;
                
            }
            
            //sqlite3_finalize(sqlStatement);
        }
        
    }
    
    //Catching Error ---- Local Database
    @catch (NSException * e) {
		NSLog(@"Exception=%@",e);
    }
    
    if(flag == 0)
    {
        
        TBRow_Data=Nil;
        return Nil;
    }
    
    return TBRow_Data;
    
    
}


/*-(NSMutableArray*)SelectTableInLocalDatabase_WP:(NSString*)query FeildCount:(int)FCount
 {
 
 int flag;
 NSMutableArray *TBRow_Data;
 NSString *TBRow_N;
 NSString *TBRow_V;
 
 @try {
 
 const char *sqlQuery = [query UTF8String];
 sqlStatement=Nil;
 
 TBRow_Data = [[[NSMutableArray alloc] init] autorelease];
 
 
 if(sqlite3_prepare_v2(database, sqlQuery, -1, &sqlStatement, NULL) == SQLITE_OK) {
 
 flag=0;
 
 while (sqlite3_step(sqlStatement) == SQLITE_ROW) {
 
 flag=1;
 
 NSMutableDictionary *Table_Row_FData = [[NSMutableDictionary alloc] init];
 
 for (int i=0;i<Fcount;i++) {
 
 TBRow_N = [NSString stringWithFormat:@"%s",(char*) sqlite3_column_name(sqlStatement,i)];
 TBRow_V = [NSString stringWithFormat:@"%s",(char*) sqlite3_column_text(sqlStatement,i)];
 
 [Table_Row_FData setObject:TBRow_V forKey:TBRow_N];
 
 TBRow_N = Nil;
 TBRow_V = Nil;
 }
 
 [TBRow_Data addObject:Table_Row_FData];
 [Table_Row_FData  release],Table_Row_FData=Nil;
 }
 
 // sqlite3_finalize(sqlStatement);
 }
 
 }
 
 @catch (NSException * e) {
 NSLog(@"Exception=%@",e);
 }
 
 if(flag == 0)
 {
 [TBRow_Data addObject:@"No Data"];
 NSLog(@"No Data");
 return FeildsValue;
 }
 
 return TBRow_Data;
 
 }*/



//Getting Table Count Row
-(int)GetTableRowCountInLocalDatabase:(NSString*)query
{
    
    int Crows;
    sqlStatement=Nil;
    
    const char *sqlQuery = [query UTF8String];
    
    @try {
        
        if(sqlite3_prepare_v2(database, sqlQuery, -1, &sqlStatement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(sqlStatement) == SQLITE_ROW)
                Crows = sqlite3_column_int(sqlStatement, 0);
        }
        else {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
            
            Crows = -1;
            
        }
        
        sqlite3_finalize(sqlStatement);
        
    }
    @catch (NSException * e) {
		NSLog(@"Exception=%@",e);
    }
    
    return Crows;
    
    
}

//########################################################################################
//########################################################################################
//End Vanstock related database class
//########################################################################################
//########################################################################################

@end
