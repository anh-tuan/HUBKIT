//
//  HKTClient+Collection.h
//  HUBKit
//
//  Created by Robert Wagstaff on 21/09/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTClient.h"
#import "HKTRequestParameter.h"

@interface HKTClient (Collection)

/**
 *  Fetch all collections matching parameter criteria. The associated HKTProducts will also be fetched and be included in the collection
 *
 *  @return A RACSignal that contains an NSArray<HKTCollection*>* including its associated HKTProducts
 */
-(RACSignal*) fetchAllCollections;

/**
 *  Fetch all collections matching parameter criteria. The associated HKTProducts will also be fetched and be included in the collection
 *
 *  @param parameters n array of HKTRequestParameters which will filter the results
 *
 *  @return A RACSignal that contains an NSArray<HKTCollection*>* including its associated HKTProducts
 */
-(RACSignal*) fetchAllCollectionsWithParameters:(NSArray<HKTRequestParameter*>*)parameters;

/**
 *  Fetch a collection by its ID number
 *
 *  @param collectionID the ID of the required collection
 *
 *  @return A RACSignal that contains an NSArray<HKTCollection*>*
 */
//- (RACSignal*)fetchCollectionWithID:(NSString*)collectionID;
- (RACSignal*)fetchPlaylistWithID:(NSString*)playlistID;
/**
 *  Fetch all collections matching parameter criteria. The associated HKTProducts will not be fetched/
 *
 *  @return A RACSignal that contains an NSArray<HKTCollection*>* without its associated HKTProducts
 */
- (RACSignal*)fetchAllCollectionsMetadata;

/**
 *  Fetch all collections matching parameter criteria. The associated HKTProducts will not be fetched/
 *
 *  @param parameters n array of HKTRequestParameters which will filter the results
 *
 *  @return A RACSignal that contains an NSArray<HKTCollection*>* without its associated HKTProducts
 */
- (RACSignal*)fetchAllCollectionsMetadataWithParameters:(NSArray<HKTRequestParameter*>*)parameters;

@end
