//
//  HKTDRMPlaybackResponse.m
//  HUBKit
//
//  Created by Robert Wagstaff on 24/09/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTDRMPlaybackResponse.h"

@implementation HKTDRMPlaybackResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              @"assetID"        :   @"asset_id",
              @"variant"        :   @"variant",
              @"message"        :   @"message",
              @"redirectURL"    :   @"redirect_uri",
              @"storeLicense"   :   @"store_license"
              }];
}

@end
