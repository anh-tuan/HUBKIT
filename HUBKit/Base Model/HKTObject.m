//
//  HKTObject.m
//  HUBKit
//
//  Created by Robert Wagstaff on 8/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTObject.h"

@implementation HKTObject

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"objectID"   :     @"id",
              @"objectType" :   @"object"
              };
}

+ (NSValueTransformer *)objectIDJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if ([value isKindOfClass:NSNumber.class]) {
            return [value stringValue];
        } else {
            return value;
        }
    }];
}

+ (NSValueTransformer*)objectTypeJSONTransformer
{
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary
            :@{
               @"product": @(HKTObjectTypeProduct),
               @"user": @(HKTObjectTypeUser),
               @"list": @(HKTObjectTypeList),
               @"collection": @(HKTObjectTypeCollection),
               @"device": @(HKTObjectTypeDevice),
               @"rail": @(HKTObjectTypeRail)
               }
            defaultValue:@(HKTObjectTypeUnknown) reverseDefaultValue:@""];
    
}

@end