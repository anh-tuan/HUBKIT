//
//  HKTImage.m
//  HUBKit
//
//  Created by Robert Wagstaff on 9/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTImageMetaData.h"

@implementation HKTImageMetaData

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"width"   :   @"width",
             @"height"  :   @"height",
             @"url"     :   @"url"
             };
}

@end
