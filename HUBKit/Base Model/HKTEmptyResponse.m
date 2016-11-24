//
//  HKTEmptyResponse.m
//  HUBKit
//
//  Created by Robert Wagstaff on 18/09/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTEmptyResponse.h"

@implementation HKTEmptyResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{}];
}

@end
