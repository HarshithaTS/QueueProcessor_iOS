#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01;
@class Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2;
@class Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01;
@class Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2T;
@class Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00;
@class Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00Response;
#import "n0.h"
@interface Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 : NSObject {
	
/* elements */
	NSString * Cdata;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * Cdata;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2 : NSObject {
	
/* elements */
	NSString * Type;
	NSString * Id_;
	NSString * Number;
	NSString * Message;
	NSString * LogNo;
	NSString * LogMsgNo;
	NSString * MessageV1;
	NSString * MessageV2;
	NSString * MessageV3;
	NSString * MessageV4;
	NSString * Parameter;
	NSNumber * Row;
	NSString * Field;
	NSString * System;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * Type;
@property (retain) NSString * Id_;
@property (retain) NSString * Number;
@property (retain) NSString * Message;
@property (retain) NSString * LogNo;
@property (retain) NSString * LogMsgNo;
@property (retain) NSString * MessageV1;
@property (retain) NSString * MessageV2;
@property (retain) NSString * MessageV3;
@property (retain) NSString * MessageV4;
@property (retain) NSString * Parameter;
@property (retain) NSNumber * Row;
@property (retain) NSString * Field;
@property (retain) NSString * System;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2T : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2T *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2 *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 : NSObject {
	
/* elements */
	NSString * Dpi2Rtrvlastsaveddata;
	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 * DpistInpt;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * Dpi2Rtrvlastsaveddata;
@property (retain) Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 * DpistInpt;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00Response : NSObject {
	
/* elements */
	Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2T * DpostMssg;
	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 * DpostOtpt;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00Response *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2T * DpostMssg;
@property (retain) Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 * DpostOtpt;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "Z_GSSMWFM_HNDL_EVNTRQST00Service.h"
#import "n0.h"
@class Z_GSSMWFM_HNDL_EVNTRQST00Binding;
@interface Z_GSSMWFM_HNDL_EVNTRQST00Service : NSObject {
	
}
+ (Z_GSSMWFM_HNDL_EVNTRQST00Binding *)Z_GSSMWFM_HNDL_EVNTRQST00Binding;
@end
@class Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse;
@class Z_GSSMWFM_HNDL_EVNTRQST00BindingOperation;
@protocol Z_GSSMWFM_HNDL_EVNTRQST00BindingResponseDelegate <NSObject>
- (void) operation:(Z_GSSMWFM_HNDL_EVNTRQST00BindingOperation *)operation completedWithResponse:(Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse *)response;
@end
@interface Z_GSSMWFM_HNDL_EVNTRQST00Binding : NSObject <Z_GSSMWFM_HNDL_EVNTRQST00BindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(Z_GSSMWFM_HNDL_EVNTRQST00BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse *)ZGssmwfmHndlEvntrqst00UsingParameters:(Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 *)aParameters ;
- (void)ZGssmwfmHndlEvntrqst00AsyncUsingParameters:(Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 *)aParameters  delegate:(id<Z_GSSMWFM_HNDL_EVNTRQST00BindingResponseDelegate>)responseDelegate;
@end
@interface Z_GSSMWFM_HNDL_EVNTRQST00BindingOperation : NSOperation {
	Z_GSSMWFM_HNDL_EVNTRQST00Binding *binding;
	Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse *response;
	id<Z_GSSMWFM_HNDL_EVNTRQST00BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) Z_GSSMWFM_HNDL_EVNTRQST00Binding *binding;
@property (readonly) Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse *response;
@property (nonatomic, assign) id<Z_GSSMWFM_HNDL_EVNTRQST00BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(Z_GSSMWFM_HNDL_EVNTRQST00Binding *)aBinding delegate:(id<Z_GSSMWFM_HNDL_EVNTRQST00BindingResponseDelegate>)aDelegate;
@end
@interface Z_GSSMWFM_HNDL_EVNTRQST00Binding_ZGssmwfmHndlEvntrqst00 : Z_GSSMWFM_HNDL_EVNTRQST00BindingOperation {
	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 * parameters;
}
@property (retain) Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 * parameters;
- (id)initWithBinding:(Z_GSSMWFM_HNDL_EVNTRQST00Binding *)aBinding delegate:(id<Z_GSSMWFM_HNDL_EVNTRQST00BindingResponseDelegate>)aDelegate
	parameters:(Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 *)aParameters
;
@end
@interface Z_GSSMWFM_HNDL_EVNTRQST00Binding_envelope : NSObject {
}
+ (Z_GSSMWFM_HNDL_EVNTRQST00Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
	NSMutableData *getResponseData;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@property (nonatomic, retain) NSMutableData *getResponseData;
@end
