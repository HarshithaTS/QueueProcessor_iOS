//
//  SingletonClass.m
//  ServiceProUniverse
//
//  Created by GSS Mysore on 08/03/13.
//
//

#import "SingletonClass.h"
#import "TouchXML.h"



@interface SingletonClass ()




@end

@implementation SingletonClass

@synthesize SOAPERRFLAG;



@synthesize gssSystemDB,serviceReportsDB,vanStockDB;
@synthesize modifySearchWhenBackFalg,mErrorFlagSAP;

@synthesize editTaskId,itemId;



static SingletonClass *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (SingletonClass *)sharedInstance {
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
        
      
        //SOAP RESPONSE ERROR
        self.SOAPERRFLAG = NO;
        
        

        //9788731821

        
    }
    
    return self;
}

// Your dealloc method will never be called, as the singleton survives for the duration of your app.
// However, I like to include it so I know what memory I'm using (and incase, one day, I convert away from Singleton).

@end
