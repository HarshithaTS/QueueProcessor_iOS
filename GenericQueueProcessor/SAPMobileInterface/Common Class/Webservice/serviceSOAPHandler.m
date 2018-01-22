//
//  serviceSOAPHandler.m
//  ServiceProUniverse
//
//  Created by GSS Mysore on 08/03/13.
//
//

#import "serviceSOAPHandler.h"
#import "Z_GSSMWFM_HNDL_EVNTRQST00Service.h"
#import "CheckedNetwork.h"

#import "GCDThreads.h"

#import "InputProperties.h"

@implementation serviceSOAPHandler




@synthesize UIC_EStatus;
@synthesize UIC_EventAPI_Name;

@synthesize whdlServiceURL;

//@synthesize SOAPDEVICEID,SAPServiceURL,GCID;


@synthesize WebR_Thread_block;



- (id)init
{
    self = [super init];
    
    if (self) {
       // Work your initialising magic here as you normally would
        
        objGCDThreads = [GCDThreads sharedInstance];
        
        objInputProperties = [InputProperties sharedInstance];
        
    }
    return self;
}

//
-(void)getResponseSAP
{
    
    self.UIC_EventAPI_Name=Nil;
 
    //WebR_Thread_block = [[NSLock alloc] init];
    
    
    if(!self.UIC_EStatus)
    {
    
        if(!((objInputProperties.ApplicationEventAPI == NULL)||([objInputProperties.ApplicationEventAPI isEqualToString:@""]||([objInputProperties.ApplicationEventAPI isEqualToString:@"NO"]))))
        {
            
            //dispatch_group_async(objGCDThreads.Task_Group,objGCDThreads.Concurrent_Queue_Default, ^{
                
                [self Getting_Response_from_SAP:[self Preparing_Request_For_SapServer]];
            //});
        }
    }
}
-(void)Getting_Response_from_SAP:(Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse*)resp
{
    //Set CXMLDocument is empty
    objInputProperties.SAP_Response_Data = nil;
    
    //BLOCKS ARE USED TO HANDLE RESPONSE MESSAGE  (ERROR OR SUCCESS).
    //unlocking
    //[self.WebR_Thread_block unlock];
    
    if([resp.getResponseData length] == 0)
    {
        if (resp.error.localizedDescription.length <= 0) {
            objInputProperties.Error_Type = @"E[$]Could not connect to the server";
        }
        else
        {
            objInputProperties.Error_Type = resp.error.localizedDescription;
        }
        
        
        //self.ErrMsg_ServiceMng(self,gss_SMng);
        
    }
    else
    {
        //Get the response here, and create CXMLDocument object for parse the response
        objInputProperties.SAP_Response_Data = [[CXMLDocument alloc] initWithData:resp.getResponseData options:0 error:nil];
        
        
    }
    
}

-(Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse*)Preparing_Request_For_SapServer
{
    
    
    //Locking for concurrent Thread
    //[WebR_Thread_block lock];
    
     //Calling Soap servive
    //SOAP Input Part
    
   NSLog(@"sel :%@",self.whdlServiceURL);
    
    Z_GSSMWFM_HNDL_EVNTRQST00Binding *binding = [[Z_GSSMWFM_HNDL_EVNTRQST00Service Z_GSSMWFM_HNDL_EVNTRQST00Binding] initWithAddress:self.whdlServiceURL];
    
    
    binding.logXMLInOut = YES;
    
	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 *par1 = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 alloc] init];
    par1.Cdata = objInputProperties.SoapDeviceIdentificationNumber;
    
	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 *par2 = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 alloc] init];
	par2.Cdata = objInputProperties.NotationString;
	
	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 *par3 = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 alloc] init];
    
    NSString *para3;
    
    if(self.UIC_EStatus) {
        objInputProperties.ApplicationEventAPI = [objInputProperties.APP_UIC_Event_API stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
    }
    
    
    para3 = [NSString stringWithFormat:@"EVENT[.]%@[.]VERSION[.]%@%@",objInputProperties.ApplicationEventAPI,objInputProperties.ApplicationVersion,objInputProperties.ApplicationResponseType];
    
    
    par3.Cdata =  para3;
	
    //Passing parameters in soap service
	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 *objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 alloc] init];
	[objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01.item addObject:par1];
	[objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01.item addObject:par2];
	[objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01.item addObject:par3];
    
    //Create Input paramater
    if(!self.UIC_EStatus) {
        
        for (int rowIndex=0; rowIndex < [objInputProperties.InputDataArray count]; rowIndex++) {
            Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 *mPara = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 alloc] init];
            mPara.Cdata = [objInputProperties.InputDataArray objectAtIndex:rowIndex];
            NSLog(@"sap request array %@",[objInputProperties.InputDataArray objectAtIndex:rowIndex]);
            [objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01.item addObject:mPara];
        }
    }
    
    //SOAP Input part end
    
    Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 *request = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 alloc] init];
    request.DpistInpt = objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01;
    
        
    
    Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse *resp = [binding ZGssmwfmHndlEvntrqst00UsingParameters:request];
    
    
    //Releasing the Object
    objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01=nil;
    request=nil;
    //*****************************************************************************************************************************
    //*****************************************************************************************************************************
    
    return resp;
}





















//-(Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse*)Preparing_Request_For_SapServer
//{
//    
//    
//    //Locking for concurrent Thread
//    //[WebR_Thread_block lock];
//    
//    //*****************************************************************************************************************************
//    //*****************************************************************************************************************************
//    //*****************************************************************************************************************************
//    //*****************************************************************************************************************************
//    self.SAPServiceURL = @"http://75.99.152.10:8050/sap/bc/srt/rfc/sap/z_gssmwfm_hndl_evntrqst00/110/z_gssmwfm_hndl_evntrqst00/z_gssmwfm_hndl_evntrqst00";
//    
//    //self.SAPServiceURL = @"http://TCW-MAS02.ThompsonCreek.com:8200/sap/bc/srt/rfc/sap/z_gssmwfm_hndl_evntrqst00/200/z_gssmwfm_hndl_evntrqst00/z_gssmwfm_hndl_evntrqst00_bndng";
//    
//    
//    
//    
//    //GENERE OUR OWN DEVICE ID
//    self.GCID = [[[UIDevice currentDevice] uniqueGlobalDeviceIdentifier] uppercaseString];
//    
//    //USE WITH SOAP ENVALOP
//    self.SOAPDEVICEID = [NSString stringWithFormat:@"DEVICE-ID:%@:DEVICE-TYPE:IOS:APPLICATION-ID:%@",[[[UIDevice currentDevice] uniqueGlobalDeviceIdentifier] uppercaseString],self.AppName];
//    
//    //For Vanstock
//    //self.SOAPDEVICEID = [NSString stringWithFormat:@"DEVICE-ID:%@:DEVICE-TYPE:IOS:APPLICATION-ID:%@",@"200000000000000",self.AppName];
//    
//    
//    //*****************************************************************************************************************************
//    //*****************************************************************************************************************************
//    //Calling Soap servive
//    //SOAP Input Part
//    
//    Z_GSSMWFM_HNDL_EVNTRQST00Binding *binding = [[Z_GSSMWFM_HNDL_EVNTRQST00Service Z_GSSMWFM_HNDL_EVNTRQST00Binding] initWithAddress:self.SAPServiceURL];
//    binding.logXMLInOut = YES;
//    
//	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 *par1 = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 alloc] init];
//    par1.Cdata = self.SOAPDEVICEID;
//    
//	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 *par2 = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 alloc] init];
//	par2.Cdata = @"NOTATION:ZML:VERSION:0:DELIMITER:[.]";
//	
//	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 *par3 = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 alloc] init];
//    
//    NSString *para3;
//    
//    if(self.UIC_EStatus) {
//        self.AppEventAPI = [self.App_UIC_Event_API stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
//    }
//    
//
//    para3 = [NSString stringWithFormat:@"EVENT[.]%@[.]VERSION[.]%@%@",self.AppEventAPI,self.AppVersion,self.AppResponseType];
//    
//    
//    par3.Cdata =  para3;
//	
//    //Passing parameters in soap service
//	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 *objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 alloc] init];
//	[objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01.item addObject:par1];
//	[objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01.item addObject:par2];
//	[objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01.item addObject:par3];
//
//    //Create Input paramater
//    if(!self.UIC_EStatus) {
//
//        for (int rowIndex=0; rowIndex < [self.RequestDataArray count]; rowIndex++) {
//            Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 *mPara = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 alloc] init];
//            mPara.Cdata = [self.RequestDataArray objectAtIndex:rowIndex];
//            NSLog(@"sap request array %@",[self.RequestDataArray objectAtIndex:rowIndex]);
//            [objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01.item addObject:mPara];
//        }
//    }
//    
//    //SOAP Input part end
//    
//    Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 *request = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 alloc] init];
//    request.DpistInpt = objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01;
//    
//    
//    Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse *resp = [binding ZGssmwfmHndlEvntrqst00UsingParameters:request];
//    
//    
//    //Releasing the Object
//    objZ_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01=Nil;
//    request=Nil;
//    //*****************************************************************************************************************************
//    //*****************************************************************************************************************************
//    
//    return resp;
//}







@end
