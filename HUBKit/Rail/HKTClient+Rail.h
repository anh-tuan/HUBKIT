//
//  HKTClient+Rail.h
//  HUBKit
//
//  Created by Chao Ruan on 10/11/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTClient.h"
#import "HKTRequestParameter.h"

@interface HKTClient (Rail)
-(RACSignal*) fetchAllRailsWithContentType:(HKTProductType)type;
- (RACSignal*) fetchAllRailsWithParameters:(NSArray<HKTRequestParameter*>*)parameters type:(HKTProductType)type;
@end
