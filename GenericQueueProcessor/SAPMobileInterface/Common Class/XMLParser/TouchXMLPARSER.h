//
//  serviceXMLPARSER.h
//  ServiceProUniverse
//
//  Created by GSS Mysore on 08/03/13.
//
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"

@interface TouchXMLPARSER : NSObject{
   
    NSMutableArray *CdataArry;
    
    
}

- (void)parseAttributesForElement:(CXMLElement*)element andDictionary:(NSMutableDictionary*)dictionary;
- (NSMutableArray *)startParsingUsingData:(CXMLDocument *) doc nodesForXPath:(NSString *) xPathStr;
- (void)parseThisNode:(CXMLNode*)node storeInDictionary:(NSMutableDictionary*)dOfNode;

@end
