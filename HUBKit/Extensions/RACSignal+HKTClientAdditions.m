//
//  RACSignal+HKTClientAdditions.m
//  HKTKit
//
//  Created by James McNamee on 17/07/2014.
//  Copyright (c) 2014 Movideo. All rights reserved.
//

#import "RACSignal+HKTClientAdditions.h"
#import "HKTListResponse.h"
#import "HKTListResponse+Parsing.h"

@implementation RACSignal (HKTClientAdditions)

- (RACSignal *)hkt_parsedProductsList
{
    return [self map:^id(HKTListResponse *listResponse) {
        NSAssert([listResponse isKindOfClass:HKTListResponse.class], @"Expected %@ to be an HKTListResponse.", listResponse);
        return [listResponse parsedProductsData];
    }];
}

- (RACSignal *)hkt_parsedCollectionsList
{
    return [self map:^id(HKTListResponse *listResponse) {
        NSAssert([listResponse isKindOfClass:HKTListResponse.class], @"Expected %@ to be an HKTListResponse.", listResponse);
        return [listResponse parsedCollectionsData];
    }];
}
- (RACSignal *)hkt_parsedRailsList
{
    return [self map:^id(HKTListResponse *listResponse) {
        NSAssert([listResponse isKindOfClass:HKTListResponse.class], @"Expected %@ to be an HKTListResponse.", listResponse);
        return [listResponse parsedRailsData];
    }];
}

- (RACSignal *)hkt_parsedMetaData
{
    return [self map:^id(HKTListResponse *listResponse) {
        NSAssert([listResponse isKindOfClass:HKTListResponse.class], @"Expected %@ to be an HKTListResponse.", listResponse);
        return [listResponse parsedMetaData];
    }];
}

@end
