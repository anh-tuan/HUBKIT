//
//  HKTAdsResponse.m
//  HUBKit
//
//  Created by Chao Ruan on 9/10/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTAdsConfriguration.h"
#import "HKTPolicy.h"
#import "HKTCuePoint.h"

@implementation HKTAdsConfriguration
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"policy":   @"policy",
             @"url":   @"url",
             @"cuePoints"        :   @"cuePoints",
             };
}

+ (NSValueTransformer*)policyJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:HKTPolicy.class];
}

+ (NSValueTransformer*)cuePointsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:HKTCuePoint.class];
}
@end
