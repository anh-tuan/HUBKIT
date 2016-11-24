//
//  HKTClient+Product.h
//  HUBKit
//
//  Created by Robert Wagstaff on 17/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKTClient.h"
#import "HKTRequestParameter.h"

@interface HKTClient (Product)

/**
*  Fetch a single product
*
*  @param productID the ID of the product to be fetched
*
*  @return a RACSignal that contains a HKTProduct
*/
- (RACSignal*)fetchProductWithID:(NSString*)productID;

/**
 *  Fetches all products
 *
 *  @return a RACSignal that contains a NSArray<HKTProduct*>*
 */
- (RACSignal*)fetchAllProducts;

/**
 *  Fetches all products matching the request parameters
 *
 *  @param parameters An array of HKTRequestParameters which will filter the results
 *
 *  @return a RACSignal that contains a NSArray<HKTProduct*>*
 */
- (RACSignal*)fetchAllProductsWithParameters:(NSArray<HKTRequestParameter*>*)parameters;

/**
 *  Fetches all products that match the search query
 *
 *  @param searchQuery String that results will be filtered on
 *
 *  @return a RACSignal that contains a NSArray<HKTProduct*>*
 */
- (RACSignal*)searchForProductsMatchingQuery:(NSString*)searchQuery;

/**
 *  Fetches all products that match the search query
 *
 *  @param searchQuery String that results will be filtered on
 *  @param parameters An array of HKTRequestParameters which will filter the results
 *
 *  @return a RACSignal that contains a NSArray<HKTProduct*>*
 */
- (RACSignal*)searchForProductsMatchingQuery:(NSString*)searchQuery withParameters:(NSArray<HKTRequestParameter*>*)parameters;

/**
 *  etch the related products of a particular product
 *
 *  @param productID he ID of the original product
 *
 *  @return  a RACSignal that contains a NSArray<HKTProduct*>*
 */
- (RACSignal*)fetchRelatedProductsWithProductID:(NSString*)productID;

/**
 *  Fetch the related products of a particular product
 *
 *  @param productID the ID of the original product
 *  @param parameters An array of HKTRequestParameters which will filter the results
 *
 *  @return a RACSignal that contains a NSArray<HKTProduct*>*
 */
- (RACSignal*)fetchRelatedProductsWithProductID:(NSString*)productID withParameters:(NSArray<HKTRequestParameter*>*)parameters;

/**
 *  Fetch the children of a product. E.g. A TV series children are Seasons. A seasons children are Episodes
 *
 *  @param productID the ID of the original product
 *
 *  @return a RACSignal that contains a NSArray<HKTProduct*>*
 */
- (RACSignal*)fetchChildrenOfParentProductID:(NSString*)parentProductID;

/**
 *  Fetch the children of a product. E.g. A TV series children are Seasons. A seasons children are Episodes
 *
 *  @param productID the ID of the original product
 *  @param parameters An array of HKTRequestParameters which will filter the results
 *
 *  @return a RACSignal that contains a NSArray<HKTProduct*>*
 */
- (RACSignal*)fetchChildrenOfParentProductID:(NSString*)parentProductID withParameters:(NSArray<HKTRequestParameter*>*)parameters;
- (RACSignal*)payProductID:(NSString*)productID withOfferingId:(NSNumber*)offering_id;
@end
