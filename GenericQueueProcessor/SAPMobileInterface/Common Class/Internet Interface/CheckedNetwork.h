

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h>


@interface CheckedNetwork : NSObject {

}

+ (BOOL) connectedToNetwork;

@end
