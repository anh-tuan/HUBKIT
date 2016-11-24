//
//  HKTListResponse+Parsing.h
//  HUBKit
//
//  Created by Robert Wagstaff on 21/09/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTListResponse.h"
@class HKTProduct;
@class HKTCollection;
@class HKTRail;
@class HKTMetaData;

@interface HKTListResponse (Parsing)

-(NSArray<HKTProduct*>*) parsedProductsData;

-(NSArray<HKTCollection*>*) parsedCollectionsData;
-(NSArray<HKTRail*>*) parsedRailsData;

-(NSArray<HKTMetaData*>*) parsedMetaData;

@end
