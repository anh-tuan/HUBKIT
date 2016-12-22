//
//  HKTCollection.m
//  HUBKit
//
//  Created by Robert Wagstaff on 10/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTCollection.h"
#import "HKTProduct.h"

@implementation HKTCollection

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              //@"title"                  :   @"title",
              //@"collectionDescription"  :   @"description",
              //@"defaultImage"           :   @"images.profile.default",// TODO check definitions of images. Seems wrong
              //@"posterImage"            :   @"images.profile.poster",
              //@"backgroundImage"        :   @"images.profile.background",
              //@"products"               :   @"data"
              @"playlist_id"    :   @"id",
              @"playlist_name"                  :   @"playlist_name",
              @"products"               :   @"list"
              }];
}


+ (NSValueTransformer*)defaultImageJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelOfClass:HKTImageMetaData.class fromJSONDictionary:value[0] error:nil];
    }];
}

+ (NSValueTransformer*)posterImageJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelOfClass:HKTImageMetaData.class fromJSONDictionary:value[1] error:nil];
    }];
}


+ (NSValueTransformer*)backgroundImageJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelOfClass:HKTImageMetaData.class fromJSONDictionary:value[2] error:nil];
    }];
}

+ (NSValueTransformer*)productsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:HKTProduct.class];
    
}

@end
