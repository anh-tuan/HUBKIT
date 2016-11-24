//
//  HKTRail.m
//  HUBKit
//
//  Created by Chao Ruan on 10/11/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTRail.h"

@implementation HKTRail
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              @"theme"  :   @"theme",
              @"collectionID"               :   @"collection_id",
              @"limit"  :   @"limit",
              @"type"   :   @"type",
              @"items"  :   @"items"
              }];
}


@end
