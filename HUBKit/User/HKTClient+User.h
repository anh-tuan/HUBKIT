//
//  HKTClient+User.h
//  HUBKit
//
//  Created by Robert Wagstaff on 18/09/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTClient.h"
#import "HKTRequestParameter.h"

@interface HKTClient (User)

/**
 *  Fetch the current user
 *
 *  @return a RACSignal that contains an HKTUser
 */
- (RACSignal*)fetchUser;

/**
 *  Fetch the favourite products for the current user
 *
 *  @return a RACSignal that contains an NSArray<HKTProduct*>*
 */
- (RACSignal*)fetchFavouriteProducts;

/**
 *  Fetch the favourite products for the current user
 *
 *  @param parameters An array of HKTRequestParameters which will filter the results
 *
 *  @return a RACSignal that contains an NSArray<HKTProduct*>*
 */
- (RACSignal*)fetchFavouriteProductsWithParameters:(NSArray<HKTRequestParameter*>*)parameters;

/**
 *  Add a product to the current users favourite list
 *
 *  @param productObjectID the ObjectID of the HKTProduct to add
 *
 *  @return a RACSignal that returns a HKTEmptyResponse
 */
- (RACSignal*)addFavouriteProduct:(NSString*)productObjectID;

/**
 *  Removes a product to the current users favourite list
 *
 *  @param productObjectID the ObjectID of the HKTProduct to add
 *
 *  @return a RACSignal that returns a HKTEmptyResponse
 */
- (RACSignal*)deleteFavouriteProduct:(NSString*)productObjectID;

/**
 *  Fetch all of the products the current user has purchased
 *
 *  @return a RACSignal that contains a NSArray<HKTProduct*>*
 */
-(RACSignal*)fetchPurchases;

/**
 *  Fetch all of the products the current user has purchased
 *
 *  @param parameters An array of HKTRequestParameters which will filter the results
 *
 *  @return a RACSignal that contains a NSArray<HKTProduct*>*
 */
-(RACSignal*)fetchPurchasesWithParameters:(NSArray<HKTRequestParameter*>*)parameters;

@end
