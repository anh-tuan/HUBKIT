//
//  RACSignal+HKTClientAdditions.h
//  HKTKit
//
//  Created by James McNamee on 17/07/2014.
//  Copyright (c) 2014 Movideo. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

//
//  Credit goes to Octokit @ GitHKT
//

@interface RACSignal (HKTClientAdditions)


/**
 *  This signal maps a HKTListResponse containing products to a signal containing An NSArray<HKTProducts*>*
 *
 *  @return a RACSignal containing An NSArray<HKTProduct*>*
 */
- (RACSignal *)hkt_parsedProductsList;

/**
 *  This signal maps a HKTListResponse containing products to a signal containing An NSArray<HKTCollection*>*
 *
 *  @return a RACSignal containing An NSArray<HKTCollection*>*
 */
- (RACSignal *)hkt_parsedCollectionsList;

/**
 *  This signal maps a HKTListResponse containing products to a signal containing An NSArray<HKTRail*>*
 *
 *  @return a RACSignal containing An NSArray<HKTRail*>*
 */
- (RACSignal *)hkt_parsedRailsList;

/**
 *  This signal maps a HKTListResponse containing metadata to a signal containing An NSArray<HKTMetaData*>*
 *
 *  @return a RACSignal containing An NSArray<HKTMetaData*>*
 */
- (RACSignal *)hkt_parsedMetaData;

@end
