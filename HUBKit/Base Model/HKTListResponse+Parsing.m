//
//  HKTListResponse+Parsing.m
//  HUBKit
//
//  Created by Robert Wagstaff on 21/09/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTListResponse+Parsing.h"
#import "HKTProduct.h"
#import "HKTCollection.h"
#import "HKTRail.h"
#import "HKTMetaData.h"

@implementation HKTListResponse (Parsing)

-(NSArray<HKTProduct*>*) parsedProductsData
{
    NSArray<HKTProduct*> *productsListResponse = [[self.currentPageOfData.rac_sequence map:^id(id value) {
        return [MTLJSONAdapter modelOfClass:HKTProduct.class fromJSONDictionary:value error:NULL];
    }] array];

    return productsListResponse;
}

-(NSArray<HKTCollection*>*) parsedCollectionsData
{
    NSArray<HKTCollection*> *collectionsListResponse = [[self.currentPageOfData.rac_sequence map:^id(id value) {
        return[MTLJSONAdapter modelOfClass:HKTCollection.class fromJSONDictionary:value error:NULL];
    }] array];
    
    return collectionsListResponse;
}

-(NSArray<HKTRail*>*) parsedRailsData
{
    NSArray<HKTRail*> *railsListResponse = [[self.currentPageOfData.rac_sequence map:^id(id value) {
        return[MTLJSONAdapter modelOfClass:HKTRail.class fromJSONDictionary:value error:NULL];
    }] array];
    
    //NSLog(@"railsListResponse: %@",railsListResponse);
    
    return railsListResponse;
}

-(NSArray<HKTMetaData*>*) parsedMetaData
{
    NSArray<HKTMetaData*> *metadataListResponse = [[self.currentPageOfData.rac_sequence map:^id(id value) {
        return [MTLJSONAdapter modelOfClass:HKTMetaData.class fromJSONDictionary:value error:NULL];
    }] array];
    
    return metadataListResponse;
}

@end
