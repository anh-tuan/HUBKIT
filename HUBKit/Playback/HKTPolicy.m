//
//  HKTAdvertisingConfig.m
//  HUBKit
//
//  Created by Chao Ruan on 9/10/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTPolicy.h"

@implementation HKTPolicy
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"provider"        :   @"provider",
             @"initialPolicy"   :   @"initial",
             @"recurringPolicy" :   @"recurring"
             };
}
@end
