//
//  HKTListResponse.m
//  HUBKit
//
//  Created by Robert Wagstaff on 15/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTListResponse.h"

@implementation HKTListResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"totalDataCount"     :   @"count",
              @"currentPageOfData"  :   @"data"
              };
}

@end
