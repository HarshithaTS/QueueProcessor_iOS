#import "Z_GSSMWFM_HNDL_EVNTRQST00Service.h"
#import <libxml/xmlstring.h>



#import "SingletonClass.h"


#if TARGET_OS_IPHONE
#import <CFNetwork/CFNetwork.h>
#endif
@implementation Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01
- (id)init
{
	if((self = [super init])) {
		Cdata = 0;
	}
	
	return self;
}
- (void)dealloc
{
	if(Cdata != nil) [Cdata release];
	
	[super dealloc];
}
- (NSString *)nsPrefix
{
	return @"";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
	NSString *nodeName = nil;
	if(elNSPrefix != nil && [elNSPrefix length] > 0)
	{
		nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
	}
	else
	{
		//nodeName = [NSString stringWithFormat:@"%@:%@", @"Z_GSSMWFM_HNDL_EVNTRQST00Service", elName];
		
		nodeName = [NSString stringWithFormat:@"%@",  elName];
	}
	
	xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
	
	
	[self addAttributesToNode:node];
	
	[self addElementsToNode:node];
	
	return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
	
}
- (void)addElementsToNode:(xmlNodePtr)node
{
	
	if(self.Cdata != 0) {
		//xmlAddChild(node, [self.Cdata xmlNodeForDoc:node->doc elementName:@"Cdata" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
		xmlAddChild(node, [self.Cdata xmlNodeForDoc:node->doc elementName:@"Cdata" elementNSPrefix:@""]);
	}
}
/* elements */
@synthesize Cdata;
/* attributes */
- (NSDictionary *)attributes
{
	NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
	
	return attributes;
}
+ (Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 *)deserializeNode:(xmlNodePtr)cur
{
	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 *newObject = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 new] autorelease];
	
	[newObject deserializeAttributesFromNode:cur];
	[newObject deserializeElementsFromNode:cur];
	
	return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
	
	
	for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
		if(cur->type == XML_ELEMENT_NODE) {
			xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
			NSString *elementString = nil;
			
			if(elementText != NULL) {
				elementString = [NSString stringWithCString:(char*)elementText encoding:NSUTF8StringEncoding];
				[elementString self]; // avoid compiler warning for unused var
				xmlFree(elementText);
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "Cdata")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.Cdata = newChild;
			}
		}
	}
}
@end
@implementation Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2
- (id)init
{
	if((self = [super init])) {
		Type = 0;
		Id_ = 0;
		Number = 0;
		Message = 0;
		LogNo = 0;
		LogMsgNo = 0;
		MessageV1 = 0;
		MessageV2 = 0;
		MessageV3 = 0;
		MessageV4 = 0;
		Parameter = 0;
		Row = 0;
		Field = 0;
		System = 0;
	}
	
	return self;
}
- (void)dealloc
{
	if(Type != nil) [Type release];
	if(Id_ != nil) [Id_ release];
	if(Number != nil) [Number release];
	if(Message != nil) [Message release];
	if(LogNo != nil) [LogNo release];
	if(LogMsgNo != nil) [LogMsgNo release];
	if(MessageV1 != nil) [MessageV1 release];
	if(MessageV2 != nil) [MessageV2 release];
	if(MessageV3 != nil) [MessageV3 release];
	if(MessageV4 != nil) [MessageV4 release];
	if(Parameter != nil) [Parameter release];
	if(Row != nil) [Row release];
	if(Field != nil) [Field release];
	if(System != nil) [System release];
	
	[super dealloc];
}
- (NSString *)nsPrefix
{
	return @"";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
	NSString *nodeName = nil;
	if(elNSPrefix != nil && [elNSPrefix length] > 0)
	{
		nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
	}
	else
	{
		//nodeName = [NSString stringWithFormat:@"%@:%@", @"Z_GSSMWFM_HNDL_EVNTRQST00Service", elName];
		nodeName = [NSString stringWithFormat:@"%@",  elName];
	}
	
	xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
	
	
	[self addAttributesToNode:node];
	
	[self addElementsToNode:node];
	
	return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
	
}
- (void)addElementsToNode:(xmlNodePtr)node
{
	
	/*
	if(self.Type != 0) {
		xmlAddChild(node, [self.Type xmlNodeForDoc:node->doc elementName:@"Type" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.Id_ != 0) {
		xmlAddChild(node, [self.Id_ xmlNodeForDoc:node->doc elementName:@"Id" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.Number != 0) {
		xmlAddChild(node, [self.Number xmlNodeForDoc:node->doc elementName:@"Number" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.Message != 0) {
		xmlAddChild(node, [self.Message xmlNodeForDoc:node->doc elementName:@"Message" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.LogNo != 0) {
		xmlAddChild(node, [self.LogNo xmlNodeForDoc:node->doc elementName:@"LogNo" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.LogMsgNo != 0) {
		xmlAddChild(node, [self.LogMsgNo xmlNodeForDoc:node->doc elementName:@"LogMsgNo" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.MessageV1 != 0) {
		xmlAddChild(node, [self.MessageV1 xmlNodeForDoc:node->doc elementName:@"MessageV1" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.MessageV2 != 0) {
		xmlAddChild(node, [self.MessageV2 xmlNodeForDoc:node->doc elementName:@"MessageV2" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.MessageV3 != 0) {
		xmlAddChild(node, [self.MessageV3 xmlNodeForDoc:node->doc elementName:@"MessageV3" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.MessageV4 != 0) {
		xmlAddChild(node, [self.MessageV4 xmlNodeForDoc:node->doc elementName:@"MessageV4" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.Parameter != 0) {
		xmlAddChild(node, [self.Parameter xmlNodeForDoc:node->doc elementName:@"Parameter" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.Row != 0) {
		xmlAddChild(node, [self.Row xmlNodeForDoc:node->doc elementName:@"Row" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.Field != 0) {
		xmlAddChild(node, [self.Field xmlNodeForDoc:node->doc elementName:@"Field" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.System != 0) {
		xmlAddChild(node, [self.System xmlNodeForDoc:node->doc elementName:@"System" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	 */
	
	if(self.Type != 0) {
		xmlAddChild(node, [self.Type xmlNodeForDoc:node->doc elementName:@"Type" elementNSPrefix:@""]);
	}
	if(self.Id_ != 0) {
		xmlAddChild(node, [self.Id_ xmlNodeForDoc:node->doc elementName:@"Id" elementNSPrefix:@""]);
	}
	if(self.Number != 0) {
		xmlAddChild(node, [self.Number xmlNodeForDoc:node->doc elementName:@"Number" elementNSPrefix:@""]);
	}
	if(self.Message != 0) {
		xmlAddChild(node, [self.Message xmlNodeForDoc:node->doc elementName:@"Message" elementNSPrefix:@""]);
	}
	if(self.LogNo != 0) {
		xmlAddChild(node, [self.LogNo xmlNodeForDoc:node->doc elementName:@"LogNo" elementNSPrefix:@""]);
	}
	if(self.LogMsgNo != 0) {
		xmlAddChild(node, [self.LogMsgNo xmlNodeForDoc:node->doc elementName:@"LogMsgNo" elementNSPrefix:@""]);
	}
	if(self.MessageV1 != 0) {
		xmlAddChild(node, [self.MessageV1 xmlNodeForDoc:node->doc elementName:@"MessageV1" elementNSPrefix:@""]);
	}
	if(self.MessageV2 != 0) {
		xmlAddChild(node, [self.MessageV2 xmlNodeForDoc:node->doc elementName:@"MessageV2" elementNSPrefix:@""]);
	}
	if(self.MessageV3 != 0) {
		xmlAddChild(node, [self.MessageV3 xmlNodeForDoc:node->doc elementName:@"MessageV3" elementNSPrefix:@""]);
	}
	if(self.MessageV4 != 0) {
		xmlAddChild(node, [self.MessageV4 xmlNodeForDoc:node->doc elementName:@"MessageV4" elementNSPrefix:@""]);
	}
	if(self.Parameter != 0) {
		xmlAddChild(node, [self.Parameter xmlNodeForDoc:node->doc elementName:@"Parameter" elementNSPrefix:@""]);
	}
	if(self.Row != 0) {
		xmlAddChild(node, [self.Row xmlNodeForDoc:node->doc elementName:@"Row" elementNSPrefix:@""]);
	}
	if(self.Field != 0) {
		xmlAddChild(node, [self.Field xmlNodeForDoc:node->doc elementName:@"Field" elementNSPrefix:@""]);
	}
	if(self.System != 0) {
		xmlAddChild(node, [self.System xmlNodeForDoc:node->doc elementName:@"System" elementNSPrefix:@""]);
	}
	
	
}
/* elements */
@synthesize Type;
@synthesize Id_;
@synthesize Number;
@synthesize Message;
@synthesize LogNo;
@synthesize LogMsgNo;
@synthesize MessageV1;
@synthesize MessageV2;
@synthesize MessageV3;
@synthesize MessageV4;
@synthesize Parameter;
@synthesize Row;
@synthesize Field;
@synthesize System;
/* attributes */
- (NSDictionary *)attributes
{
	NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
	
	return attributes;
}
+ (Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2 *)deserializeNode:(xmlNodePtr)cur
{
	Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2 *newObject = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2 new] autorelease];
	
	[newObject deserializeAttributesFromNode:cur];
	[newObject deserializeElementsFromNode:cur];
	
	return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
	
	
	for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
		if(cur->type == XML_ELEMENT_NODE) {
			xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
			NSString *elementString = nil;
			
			if(elementText != NULL) {
				elementString = [NSString stringWithCString:(char*)elementText encoding:NSUTF8StringEncoding];
				[elementString self]; // avoid compiler warning for unused var
				xmlFree(elementText);
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "Type")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.Type = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "Id")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.Id_ = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "Number")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.Number = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "Message")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.Message = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "LogNo")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.LogNo = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "LogMsgNo")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.LogMsgNo = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "MessageV1")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.MessageV1 = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "MessageV2")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.MessageV2 = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "MessageV3")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.MessageV3 = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "MessageV4")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.MessageV4 = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "Parameter")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.Parameter = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "Row")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSNumber  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.Row = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "Field")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.Field = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "System")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.System = newChild;
			}
		}
	}
}
@end
@implementation Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01
- (id)init
{
	if((self = [super init])) {
		item = [[NSMutableArray alloc] init];
	}
	
	return self;
}
- (void)dealloc
{
	if(item != nil) [item release];
	
	[super dealloc];
}
- (NSString *)nsPrefix
{
	return @"";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
	NSString *nodeName = nil;
	if(elNSPrefix != nil && [elNSPrefix length] > 0)
	{
		nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
	}
	else
	{
		//nodeName = [NSString stringWithFormat:@"%@:%@", @"Z_GSSMWFM_HNDL_EVNTRQST00Service", elName];
		nodeName = [NSString stringWithFormat:@"%@",  elName];
	}
	
	xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
	
	
	[self addAttributesToNode:node];
	
	[self addElementsToNode:node];
	
	return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
	
}
- (void)addElementsToNode:(xmlNodePtr)node
{
	
	if(self.item != 0) {
		for(Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 * child in self.item) {
			//xmlAddChild(node, [child xmlNodeForDoc:node->doc elementName:@"item" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
			xmlAddChild(node, [child xmlNodeForDoc:node->doc elementName:@"item" elementNSPrefix:@""]);
		}
	}
}
/* elements */
@synthesize item;
- (void)addItem:(Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 *)toAdd
{
	if(toAdd != nil) [item addObject:toAdd];
}
/* attributes */
- (NSDictionary *)attributes
{
	NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
	
	return attributes;
}
+ (Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 *)deserializeNode:(xmlNodePtr)cur
{
	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 *newObject = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 new] autorelease];
	
	[newObject deserializeAttributesFromNode:cur];
	[newObject deserializeElementsFromNode:cur];
	
	return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
	
	
	for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
		if(cur->type == XML_ELEMENT_NODE) {
			xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
			NSString *elementString = nil;
			
			if(elementText != NULL) {
				elementString = [NSString stringWithCString:(char*)elementText encoding:NSUTF8StringEncoding];
				[elementString self]; // avoid compiler warning for unused var
				xmlFree(elementText);
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "item")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbssDatarcrd01 class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				if(newChild != nil) [self.item addObject:newChild];
			}
		}
	}
}
@end
@implementation Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2T
- (id)init
{
	if((self = [super init])) {
		item = [[NSMutableArray alloc] init];
	}
	
	return self;
}
- (void)dealloc
{
	if(item != nil) [item release];
	
	[super dealloc];
}
- (NSString *)nsPrefix
{
	return @"";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
	NSString *nodeName = nil;
	if(elNSPrefix != nil && [elNSPrefix length] > 0)
	{
		nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
	}
	else
	{
		nodeName = [NSString stringWithFormat:@"%@:%@", @"Z_GSSMWFM_HNDL_EVNTRQST00Service", elName];
	}
	
	xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
	
	
	[self addAttributesToNode:node];
	
	[self addElementsToNode:node];
	
	return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
	
}
- (void)addElementsToNode:(xmlNodePtr)node
{
	
	if(self.item != 0) {
		for(Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2 * child in self.item) {
			//xmlAddChild(node, [child xmlNodeForDoc:node->doc elementName:@"item" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
			xmlAddChild(node, [child xmlNodeForDoc:node->doc elementName:@"item" elementNSPrefix:@""]);
		}
	}
}
/* elements */
@synthesize item;
- (void)addItem:(Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2 *)toAdd
{
	if(toAdd != nil) [item addObject:toAdd];
}
/* attributes */
- (NSDictionary *)attributes
{
	NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
	
	return attributes;
}
+ (Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2T *)deserializeNode:(xmlNodePtr)cur
{
	Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2T *newObject = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2T new] autorelease];
	
	[newObject deserializeAttributesFromNode:cur];
	[newObject deserializeElementsFromNode:cur];
	
	return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
	
	
	for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
		if(cur->type == XML_ELEMENT_NODE) {
			xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
			NSString *elementString = nil;
			
			if(elementText != NULL) {
				elementString = [NSString stringWithCString:(char*)elementText encoding:NSUTF8StringEncoding];
				[elementString self]; // avoid compiler warning for unused var
				xmlFree(elementText);
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "item")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2 class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				if(newChild != nil) [self.item addObject:newChild];
			}
		}
	}
}
@end
@implementation Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00
- (id)init
{
	if((self = [super init])) {
		Dpi2Rtrvlastsaveddata = 0;
		DpistInpt = 0;
	}
	
	return self;
}
- (void)dealloc
{
	if(Dpi2Rtrvlastsaveddata != nil) [Dpi2Rtrvlastsaveddata release];
	if(DpistInpt != nil) [DpistInpt release];
	
	[super dealloc];
}
- (NSString *)nsPrefix
{
	return @"";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
	NSString *nodeName = nil;
	if(elNSPrefix != nil && [elNSPrefix length] > 0)
	{
		nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
	}
	else
	{
		nodeName = [NSString stringWithFormat:@"%@:%@", @"Z_GSSMWFM_HNDL_EVNTRQST00Service", elName];
	}
	
	xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
	
	
	[self addAttributesToNode:node];
	
	[self addElementsToNode:node];

	return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
	
}
- (void)addElementsToNode:(xmlNodePtr)node
{
	
	if(self.Dpi2Rtrvlastsaveddata != 0) {
		//xmlAddChild(node, [self.Dpi2Rtrvlastsaveddata xmlNodeForDoc:node->doc elementName:@"Dpi2Rtrvlastsaveddata" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
		xmlAddChild(node, [self.Dpi2Rtrvlastsaveddata xmlNodeForDoc:node->doc elementName:@"Dpi2Rtrvlastsaveddata" elementNSPrefix:@""]);
	}
	if(self.DpistInpt != 0) {
		//xmlAddChild(node, [self.DpistInpt xmlNodeForDoc:node->doc elementName:@"DpistInpt" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
		xmlAddChild(node, [self.DpistInpt xmlNodeForDoc:node->doc elementName:@"DpistInpt" elementNSPrefix:@""]);
	}
}
/* elements */
@synthesize Dpi2Rtrvlastsaveddata;
@synthesize DpistInpt;
/* attributes */
- (NSDictionary *)attributes
{
	NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
	
	return attributes;
}
+ (Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 *)deserializeNode:(xmlNodePtr)cur
{
	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 *newObject = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 new] autorelease];
	
	[newObject deserializeAttributesFromNode:cur];
	[newObject deserializeElementsFromNode:cur];
	
	return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
	
	
	for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
		if(cur->type == XML_ELEMENT_NODE) {
			xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
			NSString *elementString = nil;
			
			if(elementText != NULL) {
				elementString = [NSString stringWithCString:(char*)elementText encoding:NSUTF8StringEncoding];
				[elementString self]; // avoid compiler warning for unused var
				xmlFree(elementText);
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "Dpi2Rtrvlastsaveddata")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.Dpi2Rtrvlastsaveddata = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "DpistInpt")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.DpistInpt = newChild;
			}
		}
	}
}
@end
@implementation Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00Response
- (id)init
{
	if((self = [super init])) {
		DpostMssg = 0;
		DpostOtpt = 0;
	}
	
	return self;
}
- (void)dealloc
{
	if(DpostMssg != nil) [DpostMssg release];
	if(DpostOtpt != nil) [DpostOtpt release];
	
	[super dealloc];
}
- (NSString *)nsPrefix
{
	return @"";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
	NSString *nodeName = nil;
	if(elNSPrefix != nil && [elNSPrefix length] > 0)
	{
		nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
	}
	else
	{
		nodeName = [NSString stringWithFormat:@"%@:%@", @"Z_GSSMWFM_HNDL_EVNTRQST00Service", elName];
	}
	
	xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
	
	
	[self addAttributesToNode:node];
	
	[self addElementsToNode:node];
	
	return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
	
}
- (void)addElementsToNode:(xmlNodePtr)node
{
	
	if(self.DpostMssg != 0) {
		xmlAddChild(node, [self.DpostMssg xmlNodeForDoc:node->doc elementName:@"DpostMssg" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
	if(self.DpostOtpt != 0) {
		xmlAddChild(node, [self.DpostOtpt xmlNodeForDoc:node->doc elementName:@"DpostOtpt" elementNSPrefix:@"Z_GSSMWFM_HNDL_EVNTRQST00Service"]);
	}
}
/* elements */
@synthesize DpostMssg;
@synthesize DpostOtpt;
/* attributes */
- (NSDictionary *)attributes
{
	NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
	
	return attributes;
}
+ (Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00Response *)deserializeNode:(xmlNodePtr)cur
{
	Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00Response *newObject = [[Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00Response new] autorelease];
	
	[newObject deserializeAttributesFromNode:cur];
	[newObject deserializeElementsFromNode:cur];
	
	return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
	
	
	for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
		if(cur->type == XML_ELEMENT_NODE) {
			xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
			NSString *elementString = nil;
			
			if(elementText != NULL) {
				elementString = [NSString stringWithCString:(char*)elementText encoding:NSUTF8StringEncoding];
				[elementString self]; // avoid compiler warning for unused var
				xmlFree(elementText);
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "DpostMssg")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [Z_GSSMWFM_HNDL_EVNTRQST00Service_Bapiret2T class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.DpostMssg = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "DpostOtpt")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [Z_GSSMWFM_HNDL_EVNTRQST00Service_ZgssmbstDatarcrd01 class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.DpostOtpt = newChild;
			}
		}
	}
}
@end
@implementation Z_GSSMWFM_HNDL_EVNTRQST00Service
+ (void)initialize
{
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"xsd" forKey:@"http://www.w3.org/2001/XMLSchema"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"Z_GSSMWFM_HNDL_EVNTRQST00Service" forKey:@"urn:sap-com:document:sap:soap:functions:mc-style"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"n0" forKey:@"urn:sap-com:document:sap:rfc:functions"];
}
+ (Z_GSSMWFM_HNDL_EVNTRQST00Binding *)Z_GSSMWFM_HNDL_EVNTRQST00Binding
{
	return [[[Z_GSSMWFM_HNDL_EVNTRQST00Binding alloc] initWithAddress:@"http://75.99.152.10:8074/sap/bc/srt/rfc/sap/z_gssmwfm_hndl_evntrqst00/740/z_gssmwfm_hndl_evntrqst00/z_gssmwfm_hndl_evntrqst00"] autorelease];
}
@end
@implementation Z_GSSMWFM_HNDL_EVNTRQST00Binding
@synthesize address;
@synthesize defaultTimeout;
@synthesize logXMLInOut;
@synthesize cookies;
@synthesize authUsername;
@synthesize authPassword;
- (id)init
{
	if((self = [super init])) {
		address = nil;
		cookies = nil;
		defaultTimeout = 200;//seconds
		logXMLInOut = NO;
		synchronousOperationComplete = NO;
	}
	
	return self;
}
- (id)initWithAddress:(NSString *)anAddress
{
	if((self = [self init])) {
		self.address = [NSURL URLWithString:anAddress];
	}
	
	return self;
}
- (void)addCookie:(NSHTTPCookie *)toAdd
{
	if(toAdd != nil) {
		if(cookies == nil) cookies = [[NSMutableArray alloc] init];
		[cookies addObject:toAdd];
	}
}
- (Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse *)performSynchronousOperation:(Z_GSSMWFM_HNDL_EVNTRQST00BindingOperation *)operation
{
	synchronousOperationComplete = NO;
	[operation start];
	
	// Now wait for response
	NSRunLoop *theRL = [NSRunLoop currentRunLoop];
	
	while (!synchronousOperationComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
	return operation.response;
}
- (void)performAsynchronousOperation:(Z_GSSMWFM_HNDL_EVNTRQST00BindingOperation *)operation
{
	[operation start];
}
- (void) operation:(Z_GSSMWFM_HNDL_EVNTRQST00BindingOperation *)operation completedWithResponse:(Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse *)response
{
	synchronousOperationComplete = YES;
}
- (Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse *)ZGssmwfmHndlEvntrqst00UsingParameters:(Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 *)aParameters 
{
	return [self performSynchronousOperation:[[(Z_GSSMWFM_HNDL_EVNTRQST00Binding_ZGssmwfmHndlEvntrqst00*)[Z_GSSMWFM_HNDL_EVNTRQST00Binding_ZGssmwfmHndlEvntrqst00 alloc] initWithBinding:self delegate:self
																							parameters:aParameters
																							] autorelease]];
}
- (void)ZGssmwfmHndlEvntrqst00AsyncUsingParameters:(Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 *)aParameters  delegate:(id<Z_GSSMWFM_HNDL_EVNTRQST00BindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(Z_GSSMWFM_HNDL_EVNTRQST00Binding_ZGssmwfmHndlEvntrqst00*)[Z_GSSMWFM_HNDL_EVNTRQST00Binding_ZGssmwfmHndlEvntrqst00 alloc] initWithBinding:self delegate:responseDelegate
																							 parameters:aParameters
																							 ] autorelease]];
}
- (void)sendHTTPCallUsingBody:(NSString *)outputBody soapAction:(NSString *)soapAction forOperation:(Z_GSSMWFM_HNDL_EVNTRQST00BindingOperation *)operation
{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.address 
																												 cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
																										 timeoutInterval:self.defaultTimeout];
  
    
	NSData *bodyData = [outputBody dataUsingEncoding:NSUTF8StringEncoding];
	
	if(cookies != nil) {
		[request setAllHTTPHeaderFields:[NSHTTPCookie requestHeaderFieldsWithCookies:cookies]];
	}
	[request setValue:@"wsdl2objc" forHTTPHeaderField:@"User-Agent"];
	[request setValue:soapAction forHTTPHeaderField:@"SOAPAction"];
	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%u", [bodyData length]] forHTTPHeaderField:@"Content-Length"];
	[request setValue:self.address.host forHTTPHeaderField:@"Host"];
	[request setHTTPMethod: @"POST"];
	// set version 1.1 - how?
	[request setHTTPBody: bodyData];
		
	if(self.logXMLInOut) {
		NSLog(@"OutputHeaders:\n%@", [request allHTTPHeaderFields]);
		NSLog(@"OutputBody:\n%@", outputBody);
        //NSLog(@"output HttP body %@", [request HTTPBody]);
	}
	
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:operation];
	
	operation.urlConnection = connection;
	[connection release];
}
- (void) dealloc
{
	[address release];
	[cookies release];
	[super dealloc];
}
@end
@implementation Z_GSSMWFM_HNDL_EVNTRQST00BindingOperation
@synthesize binding;
@synthesize response;
@synthesize delegate;
@synthesize responseData;
@synthesize urlConnection;
- (id)initWithBinding:(Z_GSSMWFM_HNDL_EVNTRQST00Binding *)aBinding delegate:(id<Z_GSSMWFM_HNDL_EVNTRQST00BindingResponseDelegate>)aDelegate
{
	if ((self = [super init])) {
		self.binding = aBinding;
		response = nil;
		self.delegate = aDelegate;
		self.responseData = nil;
		self.urlConnection = nil;
	}
	
	return self;
}
-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	if ([challenge previousFailureCount] == 0) {
		NSURLCredential *newCredential;
		newCredential=[NSURLCredential credentialWithUser:self.binding.authUsername
												 password:self.binding.authPassword
											  persistence:NSURLCredentialPersistenceForSession];
		[[challenge sender] useCredential:newCredential
			   forAuthenticationChallenge:challenge];
	} else {
		[[challenge sender] cancelAuthenticationChallenge:challenge];
		NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Authentication Error" forKey:NSLocalizedDescriptionKey];
		NSError *authError = [NSError errorWithDomain:@"Connection Authentication" code:0 userInfo:userInfo];
		[self connection:connection didFailWithError:authError];
	}
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)urlResponse
{
	NSHTTPURLResponse *httpResponse;
	if ([urlResponse isKindOfClass:[NSHTTPURLResponse class]]) {
		httpResponse = (NSHTTPURLResponse *) urlResponse;
	} else {
		httpResponse = nil;
	}
	
	if(binding.logXMLInOut) {
		NSLog(@"ResponseStatus: %u\n", [httpResponse statusCode]);
		NSLog(@"ResponseHeaders:\n%@", [httpResponse allHeaderFields]);
	}
	
	NSMutableArray *cookies = [[NSHTTPCookie cookiesWithResponseHeaderFields:[httpResponse allHeaderFields] forURL:binding.address] mutableCopy];
	
	binding.cookies = cookies;
	[cookies release];
  if ([urlResponse.MIMEType rangeOfString:@"text/xml"].length == 0) {
		NSError *error = nil;
		[connection cancel];
		if ([httpResponse statusCode] >= 400) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSHTTPURLResponse localizedStringForStatusCode:[httpResponse statusCode]] forKey:NSLocalizedDescriptionKey];
				
			error = [NSError errorWithDomain:@"Z_GSSMWFM_HNDL_EVNTRQST00BindingResponseHTTP" code:[httpResponse statusCode] userInfo:userInfo];
		} else {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
																[NSString stringWithFormat: @"Unexpected response MIME type to SOAP call:%@", urlResponse.MIMEType]
																													 forKey:NSLocalizedDescriptionKey];
			error = [NSError errorWithDomain:@"Z_GSSMWFM_HNDL_EVNTRQST00BindingResponseHTTP" code:1 userInfo:userInfo];
		}
				
		[self connection:connection didFailWithError:error];
  }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  if (responseData == nil) {
		responseData = [data mutableCopy];
	} else {
		[responseData appendData:data];
	}
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    SingletonClass* sharedSingleton = [SingletonClass sharedInstance];
    
    
	if (binding.logXMLInOut) {
        sharedSingleton.SOAPERRFLAG = TRUE;
        NSLog(@"ResponseError:\n%@", error);
	}
    else
        sharedSingleton.SOAPERRFLAG = FALSE;
    
	response.error = error;
	[delegate operation:self completedWithResponse:response];
}
- (void)dealloc
{
	[binding release];
	[response release];
	delegate = nil;
	[responseData release];
	[urlConnection release];
	
	[super dealloc];
}
@end
@implementation Z_GSSMWFM_HNDL_EVNTRQST00Binding_ZGssmwfmHndlEvntrqst00
@synthesize parameters;
- (id)initWithBinding:(Z_GSSMWFM_HNDL_EVNTRQST00Binding *)aBinding delegate:(id<Z_GSSMWFM_HNDL_EVNTRQST00BindingResponseDelegate>)responseDelegate
parameters:(Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00 *)aParameters
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.parameters = aParameters;
	}
	
	return self;
}
- (void)dealloc
{
	if(parameters != nil) [parameters release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse new];
	
	Z_GSSMWFM_HNDL_EVNTRQST00Binding_envelope *envelope = [Z_GSSMWFM_HNDL_EVNTRQST00Binding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(parameters != nil) [bodyElements setObject:parameters forKey:@"ZGssmwfmHndlEvntrqst00"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (responseData != nil && delegate != nil)
	{
		xmlDocPtr doc;
		xmlNodePtr cur;
		
		if (binding.logXMLInOut) {
			NSLog(@"ResponseBody:\n%@", [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
			response.getResponseData = responseData;
		}
		
		doc = xmlParseMemory([responseData bytes], [responseData length]);
		
		if (doc == NULL) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Errors while parsing returned XML" forKey:NSLocalizedDescriptionKey];
			
			response.error = [NSError errorWithDomain:@"Z_GSSMWFM_HNDL_EVNTRQST00BindingResponseXML" code:1 userInfo:userInfo];
			[delegate operation:self completedWithResponse:response];
		} else {
			cur = xmlDocGetRootElement(doc);
			cur = cur->children;
			
			for( ; cur != NULL ; cur = cur->next) {
				if(cur->type == XML_ELEMENT_NODE) {
					
					if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
						NSMutableArray *responseBodyParts = [NSMutableArray array];
						
						xmlNodePtr bodyNode;
						for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
							if(cur->type == XML_ELEMENT_NODE) {
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "ZGssmwfmHndlEvntrqst00Response")) {
									Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00Response *bodyObject = [Z_GSSMWFM_HNDL_EVNTRQST00Service_ZGssmwfmHndlEvntrqst00Response deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
								if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
									xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
									SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
							}
						}
						
						response.bodyParts = responseBodyParts;
					}
				}
			}
			
			xmlFreeDoc(doc);
		}
		
		xmlCleanupParser();
		[delegate operation:self completedWithResponse:response];
	}
}
@end
static Z_GSSMWFM_HNDL_EVNTRQST00Binding_envelope *Z_GSSMWFM_HNDL_EVNTRQST00BindingSharedEnvelopeInstance = nil;
@implementation Z_GSSMWFM_HNDL_EVNTRQST00Binding_envelope
+ (Z_GSSMWFM_HNDL_EVNTRQST00Binding_envelope *)sharedInstance
{
	if(Z_GSSMWFM_HNDL_EVNTRQST00BindingSharedEnvelopeInstance == nil) {
		Z_GSSMWFM_HNDL_EVNTRQST00BindingSharedEnvelopeInstance = [Z_GSSMWFM_HNDL_EVNTRQST00Binding_envelope new];
	}
	
	return Z_GSSMWFM_HNDL_EVNTRQST00BindingSharedEnvelopeInstance;
}
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements
{
    xmlDocPtr doc;
	
	doc = xmlNewDoc((const xmlChar*)XML_DEFAULT_VERSION);
	if (doc == NULL) {
		NSLog(@"Error creating the xml document tree");
		return @"";
	}
	
	xmlNodePtr root = xmlNewDocNode(doc, NULL, (const xmlChar*)"Envelope", NULL);
	xmlDocSetRootElement(doc, root);
	
	xmlNsPtr soapEnvelopeNs = xmlNewNs(root, (const xmlChar*)"http://schemas.xmlsoap.org/soap/envelope/", (const xmlChar*)"soap");
	xmlSetNs(root, soapEnvelopeNs);
	
	xmlNsPtr xslNs = xmlNewNs(root, (const xmlChar*)"http://www.w3.org/1999/XSL/Transform", (const xmlChar*)"xsl");
	xmlNewNs(root, (const xmlChar*)"http://www.w3.org/2001/XMLSchema-instance", (const xmlChar*)"xsi");
	
	xmlNewNsProp(root, xslNs, (const xmlChar*)"version", (const xmlChar*)"1.0");
	
	xmlNewNs(root, (const xmlChar*)"http://www.w3.org/2001/XMLSchema", (const xmlChar*)"xsd");
	xmlNewNs(root, (const xmlChar*)"urn:sap-com:document:sap:soap:functions:mc-style", (const xmlChar*)"Z_GSSMWFM_HNDL_EVNTRQST00Service");
	xmlNewNs(root, (const xmlChar*)"urn:sap-com:document:sap:rfc:functions", (const xmlChar*)"n0");
	
	if((headerElements != nil) && ([headerElements count] > 0)) {
		xmlNodePtr headerNode = xmlNewDocNode(doc, soapEnvelopeNs, (const xmlChar*)"Header", NULL);
		xmlAddChild(root, headerNode);
		
		for(NSString *key in [headerElements allKeys]) {
			id header = [headerElements objectForKey:key];
			xmlAddChild(headerNode, [header xmlNodeForDoc:doc elementName:key elementNSPrefix:nil]);
		}
	}
	
	if((bodyElements != nil) && ([bodyElements count] > 0)) {
		xmlNodePtr bodyNode = xmlNewDocNode(doc, soapEnvelopeNs, (const xmlChar*)"Body", NULL);
		xmlAddChild(root, bodyNode);
		
		for(NSString *key in [bodyElements allKeys]) {
			id body = [bodyElements objectForKey:key];
			xmlAddChild(bodyNode, [body xmlNodeForDoc:doc elementName:key elementNSPrefix:nil]);
		}
	}
	
	xmlChar *buf;
	int size;
	xmlDocDumpFormatMemory(doc, &buf, &size, 1);
	
	NSString *serializedForm = [NSString stringWithCString:(const char*)buf encoding:NSUTF8StringEncoding];
	xmlFree(buf);
	
	xmlFreeDoc(doc);	
	return serializedForm;
}
@end
@implementation Z_GSSMWFM_HNDL_EVNTRQST00BindingResponse
@synthesize headers;
@synthesize bodyParts;
@synthesize error;
@synthesize getResponseData;
- (id)init
{
	if((self = [super init])) {
		headers = nil;
		bodyParts = nil;
		error = nil;
		getResponseData = nil;
	}
	
	return self;
}
-(void)dealloc {
    self.headers = nil;
    self.bodyParts = nil;
    self.error = nil;	
    [super dealloc];
}
@end
