//
//  HKTListResponse.h
//  HUBKit
//
//  Created by Robert Wagstaff on 15/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTObject.h"

@interface HKTListResponse : HKTObject

@property (nonatomic, copy, readonly) NSNumber *totalDataCount;
@property (nonatomic, copy, readonly) NSArray<HKTObject*> *currentPageOfData;

@end
