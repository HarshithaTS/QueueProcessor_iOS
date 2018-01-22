//
//  serviceSOAPHandler.h
//  ServiceProUniverse
//
//  Created by GSS Mysore on 08/03/13.
//
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h>
#import <UIKit/UIKit.h>
#import "Z_GSSMWFM_HNDL_EVNTRQST00Service.h"
#import "TouchXML.h"
#import "GCDThreads.h"

#import "InputProperties.h"


@interface serviceSOAPHandler : NSObject
{

    
    GCDThreads *objGCDThreads;
    InputProperties *objInputProperties;
}



@property (nonatomic, retain) NSString *whdlServiceURL;





//Dynamic UI Creation
@property(nonatomic,assign) BOOL UIC_EStatus;
@property(nonatomic,retain) NSString *UIC_EventAPI_Name;


@property (nonatomic,retain) NSLock *WebR_Thread_block;


//End SOAP

-(void)getResponseSAP;
-(Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse*)Preparing_Request_For_SapServer;

-(void)Getting_Response_from_SAP:(Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse*)resp;
@end
