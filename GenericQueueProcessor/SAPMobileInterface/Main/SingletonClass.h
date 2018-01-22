//
//  SingletonClass.h
//  ServiceProUniverse
//
//  Created by GSS Mysore on 08/03/13.
//
//

#import <Foundation/Foundation.h>



@interface SingletonClass : NSObject {
    

    
    BOOL SOAPERRFLAG;
    
    
    
}

@property (nonatomic, assign) BOOL SOAPERRFLAG;



//DATABASE Variables
@property (nonatomic, retain) NSString *gssSystemDB;
@property (nonatomic, retain) NSString *serviceReportsDB;
@property (nonatomic, retain) NSString *vanStockDB;
//END DATABASE

@property (nonatomic, assign) BOOL modifySearchWhenBackFalg;
@property (nonatomic, assign) BOOL mErrorFlagSAP;

@property (nonatomic,retain) NSString *editTaskId;
@property (nonatomic,retain) NSString *itemId;







+ (id)sharedInstance;
@end