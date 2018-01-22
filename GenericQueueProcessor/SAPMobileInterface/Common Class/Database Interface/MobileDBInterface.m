//
//  MobileDBInterface.m
//  ServiceProUniverse
//
//  Created by GSS Mysore on 2/19/14.
//
//

#import "MobileDBInterface.h"

#import "ServiceDBHandler.h"

@implementation MobileDBInterface



-(void) createSQLQueryStringFromParsedData:(NSMutableArray *) parsedResponseArry {
    
    NSString *tableName;
    NSString *createFieldStr = @"";
    NSString *insertFieldStrValue = @"";
    NSString *tempValueStr = @"";
    NSString *cdataStr = @"";
    NSString *responseType = @"";
   // NSString *respTypeStr = @"";
    NSMutableArray *createTableDescStrArry = [[NSMutableArray alloc] init];
    NSMutableArray *InsertQryStrArry = [[NSMutableArray alloc] init];
    NSMutableArray *dropTableStrArry = [[NSMutableArray alloc] init];
    NSMutableArray *deleteTblRcdArry = [[NSMutableArray alloc] init];
    
    
    if (parsedResponseArry != NULL || [parsedResponseArry count]>0) {
   
    for (int index=0; index < [parsedResponseArry count]; index++) {
        
        NSArray *dataTypeFieldArray = [parsedResponseArry objectAtIndex:index];
        int strIndex = 0;
        //NSLog(@"Datatypefield array:%@",dataTypeFieldArray);
        
        
        //Index = 0  -  DATA-TYPE String
        //Index = 1  -  Table Name
        //Index = 2  -  Response Type & Row Count Details (Optional)
        
        //Based on this string we can call metadata part or data part
        cdataStr = [dataTypeFieldArray objectAtIndex:0];
   
        //Get Metadata for table creation/table structure
        if ([cdataStr isEqualToString:@"DATA-TYPE"]) {
            
            //Get Table Name to local variable
            tableName = [dataTypeFieldArray objectAtIndex:1];
            
            //Get response type to local variable
            if ([[dataTypeFieldArray objectAtIndex:2] hasPrefix:@"RESPONSE-TYPE"]) {
                responseType = [dataTypeFieldArray objectAtIndex:2];
                strIndex = 3;
            }
            else {
                responseType = @"";
                strIndex = 2;
            }
            
            createFieldStr = @"";
            
            

            
            
            //Get fields from index 3
            for (int fields=strIndex; fields <= [dataTypeFieldArray count]-1; fields++) {
                
                    //Prepare create table string
                    createFieldStr = [createFieldStr stringByAppendingString:[dataTypeFieldArray objectAtIndex:fields]];
                    createFieldStr = [createFieldStr stringByAppendingString:@" TEXT"];
                    
                    if(fields<([dataTypeFieldArray count]- 1))
                    {
                        createFieldStr = [createFieldStr stringByAppendingString:@","];
                        
                    }
                
                    //Prepare table description
                    insertFieldStrValue = [insertFieldStrValue stringByAppendingString:[dataTypeFieldArray objectAtIndex:fields]];
                    if(fields<([dataTypeFieldArray count]- 1))
                    {
                        insertFieldStrValue = [insertFieldStrValue stringByAppendingString:@","];
                    
                    }
                
            }
            
            //Based on the response type, condition will work
            if ([self parseResponseType:responseType]) {
                //Drop Table string
                [dropTableStrArry addObject:[NSString stringWithFormat:@"DROP TABLE IF EXISTS %@",tableName]];
                
                //Add created query string into temporary array to later process
                [createTableDescStrArry addObject:[NSString stringWithFormat:@"CREATE TABLE %@ (%@)",tableName,createFieldStr]];
            }
            
            
            
            //Collect table and field name into one table for developer purpose
            //Add created query string into temporary array to later process
            [InsertQryStrArry addObject:[NSString stringWithFormat:@"INSERT INTO Table_Desc VALUES ('%@','%@')", tableName, insertFieldStrValue]];

        }
        //Filter Data part
        else if (![cdataStr hasPrefix:@"NOTATION"] && ![cdataStr hasPrefix:@"EVENT-RESPONSE"] && ![cdataStr hasPrefix:@"DATA-TYPE"]) {
            
            //Get tablename from Array
            tableName = [dataTypeFieldArray objectAtIndex:0];
            
            //Based on the response type, condition will work
            if (![self parseResponseType:responseType]) {
                //DELETE ALL RECORDS FROM THE TABLE (for full-sets and delta-sets feature)
                [deleteTblRcdArry addObject:[NSString stringWithFormat:@"DELETE FROM %@",tableName]];
            }
            
            for (int values=1; values <= [dataTypeFieldArray count]-1; values++) {
                tempValueStr = [tempValueStr stringByAppendingString:@"'"];
                tempValueStr = [tempValueStr stringByAppendingString:[[[dataTypeFieldArray objectAtIndex:values] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByReplacingOccurrencesOfString:@"'" withString:@"`"] ];
                tempValueStr = [tempValueStr stringByAppendingString:@"'"];
                
                if(values<([dataTypeFieldArray count]- 1))
                {
                    tempValueStr = [tempValueStr stringByAppendingString:@","];
                }
            }
            
            //Inserting data into Sqlite DB
            [InsertQryStrArry addObject:[NSString stringWithFormat:@"INSERT INTO  %@ VALUES (%@)",tableName,tempValueStr]];
            tempValueStr = @"";
        }
        
    }
    
    //Add created query string into temporary array to later process
    //NSLog(@"Table Creation Query Array: %@",createTableStrArry);
    // NSLog(@"Insert Query String %@",InsertQryStrArry);
    
    //create table description table
    [createTableDescStrArry addObject:[NSString stringWithFormat:@"CREATE TABLE Table_Desc (TABLENAME TEXT,FIELDS TEXT)"]];
        
    //Delete existing record from table description table
    [dropTableStrArry addObject:[NSString stringWithFormat:@"DROP TABLE IF EXISTS Table_Desc"]];
        
    //Push All constructed query strings into sqlite
    
    //Drop table if exists
    [self pushParsedDataIntoSqliteDatabase:dropTableStrArry];
    //Table Structure Creation
    [self pushParsedDataIntoSqliteDatabase:createTableDescStrArry];
    //Delete records from existing table if necessary
    [self pushParsedDataIntoSqliteDatabase:deleteTblRcdArry];
    //Insert data into table
    [self pushParsedDataIntoSqliteDatabase:InsertQryStrArry];
    //End data creation
        
        
    
    // Empty created array
     createTableDescStrArry =nil;
     InsertQryStrArry = nil;
     dropTableStrArry = nil;
    
    
     }
    
}


-(void) pushParsedDataIntoSqliteDatabase: (NSMutableArray *) dbData {
    
    //Create DBHandler Instants and assign value to its property
    ServiceDBHandler *objServiceDBHandler = [[ServiceDBHandler alloc] init];
    
    
    if (dbData != NULL && [dbData count]>0) {
        //Open Database
        //if ([objServiceDBHandler OpenSqliteDBConnection])
        //{
            //Execute sqlite query
            for (int rowCount=0; rowCount <= [dbData count]-1; rowCount++) {
                
                objServiceDBHandler.qryString = [dbData objectAtIndex:rowCount];
                
                NSLog(@"Query String: %@", objServiceDBHandler.qryString);
                
                if ([objServiceDBHandler excuteSqliteQryString]) {
                    NSLog(@"Query Executed!!");
                }
                else {
                    NSLog(@"Qry Str : %@", [dbData objectAtIndex:rowCount]);
                    NSLog(@"Query Not Executed!!");
                    
                }
                objServiceDBHandler.qryString = @"";
           // }
            //close database
            //[objServiceDBHandler closeSqliteDBConnection];
            
        }
    }
    
   objServiceDBHandler= nil;
    
}

-(BOOL) parseResponseType:(NSString *) strResponseType {
    
    //IF RESPONSE IS NOT BLANK THEN FULLSETS/DELTASETS FEATURE ENABLED SO FURTHER DATA HANDLING PROCESS WILL GO WIDH FULL SETS CONDITIONS
    if (![strResponseType isEqualToString:@""]) {
   
        NSString *responseType = @"";
        NSInteger rowCount;
        
        
        NSArray *parseDataType = [strResponseType componentsSeparatedByString:@";"];
        
        
        NSRange range = [[parseDataType objectAtIndex:0] rangeOfString:@"="];
        responseType = [[[parseDataType objectAtIndex:0] substringFromIndex:NSMaxRange(range)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        
        range = [[parseDataType objectAtIndex:1] rangeOfString:@"="];
        rowCount = [[[[parseDataType objectAtIndex:1] substringFromIndex:NSMaxRange(range)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] integerValue];
        
        if ([responseType isEqualToString:@"FULL-SETS"] && rowCount == 0) {
            
            //Clear the table for the data type in the LDB
            //selvan = Drop Table and Create Table
            
            return YES;
        }
        else if ([responseType isEqualToString:@"FULL-SETS"] && rowCount > 0) {
            
            //Refresh the table in the local DB with the n rows from SAP
            
            //selvan =  Drop Table and Create Table
            return YES;
            
            
        }
        else if ([responseType isEqualToString:@"DELTA-SETS"] && rowCount == 0)
        {
            //If item selection is not applicable (e.g. SO list), Clear the table for the data type in the LDB; if item selection is applicable (e.g. Inventory for specific materials), delete the rows in the LDB corresponding to the item selection
            return YES;
            
        }
        else if ([responseType isEqualToString:@"DELTA-SETS"] && rowCount > 0)
        {
            //If item selection is not applicable (e.g. SO list), Refresh the table for the data type in the LDB with the data set received form the server; if item selection is applicable (e.g. Inventory for specific materials), refresh the rows in the LDB corresponding to the item selection with the data set received from the server
            return NO;
            
        }
        else
        {
            return YES;
        }
       
//        NSLog(@"Response %@", parseDataType);
//        NSLog(@"Response Type %@", responseType);
//        NSLog(@"Row Count %d", rowCount);
    }
    else
        return YES;
}


@end
