//
//  MobileDBInterface.h
//  ServiceProUniverse
//
//  Created by GSS Mysore on 2/19/14.
//
//

#import <Foundation/Foundation.h>

@interface MobileDBInterface : NSObject
{}



-(void) createSQLQueryStringFromParsedData:(NSMutableArray *) parsedResponseArry;
-(void) pushParsedDataIntoSqliteDatabase: (NSMutableArray *) dbData;

-(BOOL) parseResponseType:(NSString *) strResponseType;

@end
