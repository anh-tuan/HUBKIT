//
//  HKTClient+User.m
//  HUBKit
//
//  Created by Robert Wagstaff on 18/09/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTClient+User.h"
#import "HKTUser.h"
#import "HKTListResponse.h"
#import "HKTEmptyResponse.h"
#import "HKTRequestParameter.h"
#import "RACSignal+HKTClientAdditions.h"

@implementation HKTClient (User)

#pragma mark - User
- (RACSignal *)fetchUser {
    NSURLRequest *request = [self createRequestForJSONResource:@"user"
                                                    method:URLRequestMethodTypeGET
                                                parameters:nil];
    //NSLog(@"fetchUser request: %@",request);
    return [self enqueueRequest:request resultClass:HKTUser.class];
}

#pragma mark - Favourite
- (RACSignal*)fetchFavouriteProducts
{
    return [self fetchFavouriteProductsWithParameters:nil];
}

- (RACSignal*)fetchFavouriteProductsWithParameters:(NSArray<HKTRequestParameter*>*)parameters
{
    NSURLRequest *request = [self createRequestForJSONResource:@"user/favourites"
                                                    method:URLRequestMethodTypeGET
                                                parameters:[HKTRequestParameter dictionaryForRequestParameters:parameters]];
    //NSLog(@"fetchFavouriteProductsWithParameters parameters: %@",parameters);
    return [[self enqueueRequest:request resultClass:HKTListResponse.class] hkt_parsedProductsList];
}

- (RACSignal*)addFavouriteProduct:(NSString*)productObjectID
{
    NSURLRequest *request = [self createRequestForJSONResource:@"user/favourites"
                                                    method:URLRequestMethodTypePOST
                                                parameters:@{@"product_id" : productObjectID}];
    
    return [self enqueueRequest:request resultClass:HKTEmptyResponse.class];
}

- (RACSignal*)deleteFavouriteProduct:(NSString*)productObjectID
{
    NSURLRequest *request = [self createRequestForJSONResource:[NSString stringWithFormat: @"user/favourites/%@", productObjectID]
                                                    method:URLRequestMethodTypeDELETE
                                                parameters:nil];
    
    return [self enqueueRequest:request resultClass:HKTEmptyResponse.class];
}

#pragma mark - Purchases
-(RACSignal*)fetchPurchases
{
    return [self fetchPurchasesWithParameters:nil];
}

-(RACSignal*)fetchPurchasesWithParameters:(NSArray<HKTRequestParameter*>*)parameters
{
    NSURLRequest *request = [self createRequestForJSONResource:@"user/purchases"
                                                    method:URLRequestMethodTypeGET
                                                parameters:[HKTRequestParameter dictionaryForRequestParameters:parameters]];
    
    //NSLog(@"fetchPurchasesWithParameters parameters: %@",parameters);
    
    return [[self enqueueRequest:request resultClass:HKTListResponse.class] hkt_parsedProductsList];
}

@end
