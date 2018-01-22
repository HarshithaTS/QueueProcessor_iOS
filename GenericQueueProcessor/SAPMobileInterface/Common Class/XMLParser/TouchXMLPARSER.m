//
//  serviceXMLPARSER.m
//  ServiceProUniverse
//
//  Created by GSS Mysore on 08/03/13.
//
//

#import "TouchXMLPARSER.h"
#import "TouchXML.h"
#import "SingletonClass.h"
#import "ServiceDBHandler.h"

@implementation TouchXMLPARSER

// a method to grab the attributes.
- (void)parseAttributesForElement:(CXMLElement*)element andDictionary:(NSMutableDictionary*)dictionary {
    NSString *strName,*strValue;
    NSArray *arAttributes = [(CXMLElement*)element attributes];
    for (int i=0; i <= arAttributes.count; i++) {
        strName = [[arAttributes objectAtIndex:i] name];
        strValue = [[arAttributes objectAtIndex:i] stringValue];
        if(strName && strValue && [strName length] >0 && [strValue length]>0) {
            [dictionary setValue:strValue forKey:strName];
        }
    }
}

// a method to parse the node &amp; store in dictionary
- (void)parseThisNode:(CXMLNode*)node storeInDictionary:(NSMutableDictionary*)dOfNode {
    NSString *strName = [node name];
    NSString *strValue = [node stringValue];
    //if(strName && [strName length]>0 && ![strName isEqualToString:@"Type"]) {
    if(strName && [strName length]>0) {
        
        NSMutableDictionary *dOfAttributes = [NSMutableDictionary dictionary];
        
         // if node has value
        if(strValue && [strValue length]>0) {
            [dOfAttributes setValue:strValue forKey:@"Cdata"];
            
            
            
            //Splite cdata value and store into nsarray
            NSMutableArray *dataTypeValueArray = [[NSMutableArray alloc] init];
            dataTypeValueArray = [(NSArray *) [[strValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsSeparatedByString:@"[.]"] mutableCopy];
            
            [CdataArry addObject:dataTypeValueArray];
        }
        
        // if node has attributes
        if([node isKindOfClass:[CXMLElement class]] && [(CXMLElement*)node attributes].count >0) {
            [self parseAttributesForElement:(CXMLElement*)node andDictionary:dOfAttributes];
        }
        

    }
}

// pass the data to this method &amp; it will return a dictionary
- (NSMutableArray *)startParsingUsingData:(CXMLDocument *) doc nodesForXPath:(NSString *) xPathStr {
    // create a mutable-empty dictionary wich will hold the data
    NSMutableDictionary *dictionaryParsed = [NSMutableDictionary dictionary];
    
    CdataArry = [NSMutableArray array];
    
        // grab all the tags of XML
        NSArray *nodes = [doc nodesForXPath:xPathStr error:nil];
    
        //NSLog(@"Nodes %@", nodes);
    
    for(CXMLDocument *node in nodes)
    {

        // start a loop to goThrough each tag of xml
        for (CXMLNode *nodeFeed in [node children]) {
            
            //NSLog(@"node Feed %@",[nodeFeed name]);
            // verify that you reached to desired tag or not
            if([[nodeFeed name] isEqualToString:@"item"]) {
                for(CXMLNode *childNode2 in [nodeFeed children])
                {
                    // just write this code to get data parsed &amp; stored in our dictionary
                    [self parseThisNode:childNode2 storeInDictionary:dictionaryParsed];
                    
                }
            }
        }
        
    }
    // return the dictionary.
    if([CdataArry count]>0) {
        return CdataArry;
    } else {
        return nil;
    }
}



@end
