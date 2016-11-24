//
//  HKTCuePoint.m
//  HUBKit
//
//  Created by Chao Ruan on 9/10/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTCuePoint.h"

@implementation HKTCuePoint
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"type" : @"type",
             @"value": @"value",
             };
}

+ (NSValueTransformer*)typeJSONTransformer
{
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary
            :@{
               @"seconds" :@(HKTCuePointTypeSeconds),
               @"percentage" :@(HKTCuePointTypePercentage),
               }
            defaultValue:@(HKTCuePointTypeUnknown) reverseDefaultValue:@""];
}

@end
