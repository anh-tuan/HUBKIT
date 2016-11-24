//
//  HKTMetaData.m
//  HUBKit
//
//  Created by Infosys on 23/11/15.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTMetaData.h"

@implementation HKTMetaData

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"type"   :    @"type",
              @"name"   :    @"value"
              };
}

+ (NSValueTransformer*)metadataTypeJSONTransformer
{
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary
            :@{
               @"genre": @(HKTMetaDataTypeGenre),
               @"country": @(HKTMetaDataTypeCountry)
               }
            defaultValue:@(HKTMetaDataTypeUnknown) reverseDefaultValue:@""];
    
}

@end
