//
//  serviceDBHandler.h
//  ServiceProUniverse
//
//  Created by GSS Mysore on 08/03/13.
//
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "InputProperties.h"

@interface ServiceDBHandler : NSObject
{
    
   	//Database instance and database names
	sqlite3 *database;
    sqlite3_stmt *sqlStatement;
    
    InputProperties *objInputProperties;
}


//@property(retain, nonatomic) NSString *dbName;
@property(retain, nonatomic) NSString *qryString;
//@property(assign) BOOL createDBflag;

//Database property
//@property(nonatomic, retain) NSString * CreateDBFlag;
//@property(nonatomic, retain) NSString * TargetDB;
@property(nonatomic, retain) NSString * Optns;
@property(nonatomic, retain) NSString * Others;



+ (id)sharedInstance;

-(BOOL)createEditableCopyOfDatabaseIfNotThere;
-(BOOL)createEditableCopyOfDatabaseIfNeeded;
-(NSString *)documentDirectoryServiceManagemenetDBPath;
-(int)insertDataIntoDB;
-(BOOL)excuteSqliteQryString;
-(NSMutableArray *)fetchDataFrmSqlite;
-(BOOL)OpenSqliteDBConnection;
-(void)closeSqliteDBConnection;

//########################################################################################
//########################################################################################
//Vanstock related database class
//########################################################################################
//########################################################################################
-(BOOL)Open_Database:(NSString*)DBName;
-(void)Close_Database;
-(BOOL)CreateTableInLocalDatabase:(NSString *)query;
-(BOOL)InsertTableInLocalDatabase:(NSString*)query;
-(BOOL)UpdateTableInLocalDatabase:(NSString*)query;
-(BOOL)DeleteTableInLocalDatabase:(NSString*)query;
-(NSMutableArray*)SelectTableInLocalDatabase:(NSString*)query;
//-(NSMutableArray*)SelectTableInLocalDatabase_WP:(NSString*)query FeildCount:(int)FCount;
-(int)GetTableRowCountInLocalDatabase:(NSString*)query;
//########################################################################################
//########################################################################################
//End - Vanstock related database class
//########################################################################################
//########################################################################################

@end
