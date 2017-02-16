//
//  HKTClient+Product.m
//  HUBKit
//
//  Created by Robert Wagstaff on 17/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTClient+Product.h"
#import "HKTProduct.h"
#import <Mantle/Mantle.h>

@implementation HKTClient (Product)

- (RACSignal *)fetchProductWithID:(NSString *)productID
{
    
    //NSLog(@"fetchProductWithID");
    NSURLRequest *request = [self createRequestForResource:[@"products/" stringByAppendingString:productID]
                                                    method:URLRequestMethodTypeGET
                                                parameters:nil];
    
    return [self enqueueRequest:request resultClass:HKTProduct.class];
}

- (RACSignal*)fetchAllProducts
{
    return [self fetchAllProductsWithParameters:nil];
}

- (RACSignal*)fetchAllProductsWithParameters:(NSArray<HKTRequestParameter*>*)parameters
{
    NSURLRequest *request = [self createRequestForResource:@"products"
                                                    method:URLRequestMethodTypeGET
                                                parameters:[HKTRequestParameter dictionaryForRequestParameters:parameters]];
    
    return [[self enqueueRequest:request resultClass:HKTListResponse.class] hkt_parsedProductsList];
}

- (RACSignal*)searchForProductsMatchingQuery:(NSString*)searchQuery
{
    return [self searchForProductsMatchingQuery:searchQuery withParameters:nil];
}

- (RACSignal*)searchForProductsMatchingQuery:(NSString*)searchQuery withParameters:(NSArray<HKTRequestParameter*>*)parameters {
    
    NSDictionary* requestParams = [HKTRequestParameter dictionaryForRequestParameters:parameters];
    requestParams = [requestParams mtl_dictionaryByAddingEntriesFromDictionary:@{@"q" : searchQuery}];
  
    NSLog(@"searchForProductsMatchingQuery requestParams: %@",requestParams);
    NSURLRequest *request = [self createRequestForResource:@"products/search"
                                                    method:URLRequestMethodTypeGET
                                                parameters:requestParams];
    
    return [[self enqueueRequest:request resultClass:HKTListResponse.class] hkt_parsedProductsList];
}
-(RACSignal*)payProductID:(NSString*)productID withOfferingId:(NSNumber*)offering_id
{
    NSDictionary *dictParameter = [NSDictionary dictionaryWithObjects:@[offering_id,@"credits"] forKeys:@[@"offering_id",@"payment_type"]];
    NSURLRequest *request = [self createRequestForResource:[NSString stringWithFormat:@"products/%@/purchase", productID]
                                                    method:URLRequestMethodTypePOST
                                                parameters:dictParameter];
    
    return [[self enqueueRequest:request resultClass:HKTListResponse.class] hkt_parsedProductsList];
}
- (RACSignal*)fetchRelatedProductsWithProductID:(NSString*)productID
{
    return [self fetchRelatedProductsWithProductID:productID withParameters:nil];
}

-(RACSignal*)fetchRelatedProductsWithProductID:(NSString*)productID withParameters:(NSArray<HKTRequestParameter*>*)parameters
{
    NSURLRequest *request = [self createRequestForResource:[NSString stringWithFormat:@"products/%@/related", productID]
                                                    method:URLRequestMethodTypeGET
                                                parameters:[HKTRequestParameter dictionaryForRequestParameters:parameters]];
    
    return [[self enqueueRequest:request resultClass:HKTListResponse.class] hkt_parsedProductsList];
}

- (RACSignal*)fetchChildrenOfParentProductID:(NSString*)parentProductID
{
    return [self fetchChildrenOfParentProductID:parentProductID withParameters:nil];
}

- (RACSignal*)fetchChildrenOfParentProductID:(NSString*)parentProductID withParameters:(NSArray<HKTRequestParameter*>*)parameters
{
    NSURLRequest *request = [self createRequestForResource:[NSString stringWithFormat:@"products/%@/episodes?", parentProductID]
                                                    method:URLRequestMethodTypeGET
                                                parameters:[HKTRequestParameter dictionaryForRequestParameters:parameters]];
    
    return [[self enqueueRequest:request resultClass:HKTListResponse.class] hkt_parsedProductsList];
}

@end
