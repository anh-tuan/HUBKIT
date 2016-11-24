//
//  HKTClient+MetaData.h
//  HUBKit
//
//  Created by Infosys on 24/11/15.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTClient.h"
#import "HKTRequestParameter.h"

@interface HKTClient (MetaData)

/**
 *  Fetches all genres of the given content type
 *
 *  @param parameter HKTContentType which will filter the results
 *
 *  @return a RACSignal that contains a NSArray<HKTMetaData*>*
 */
- (RACSignal*)fetchGenresWithContentTypeOptions:(HKTContentType)contentTypeOptions;

/**
 *  Fetches all countries of the given content type
 *
 *  @param parameter HKTContentType which will filter the results
 *
 *  @return a RACSignal that contains a NSArray<HKTMetaData*>*
 */
- (RACSignal*)fetchCountriesWithContentTypeOptions:(HKTContentType)contentTypeOptions;

@end
