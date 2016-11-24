//
//  HKTProductOffering.h
//  HUBKit
//
//  Created by Robert Wagstaff on 9/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HUBKit.h"
#import "MTLModel.h"

@interface HKTProductOffering : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) HKTProductType productType;
@property (nonatomic, readonly) HKTVariant variant;
@property (nonatomic, readonly) NSString* price;
@property (nonatomic, readonly) NSNumber* offeringId;
@property (nonatomic, readonly) NSString* currency;
@property (nonatomic, readonly) NSString* payment_type;
@property (nonatomic, readonly) NSNumber* timeRemaining;
@property (nonatomic, readonly, copy) NSDate* startDate;
@property (nonatomic, readonly, copy) NSDate* endDate;
@property (nonatomic, readonly) BOOL entitled;
- (NSString*)convertTimeRemaining;
- (NSString*)navgationBarTitle;
@end;