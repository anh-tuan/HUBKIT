//
//  HKTAdsResponse.h
//  HUBKit
//
//  Created by Chao Ruan on 9/10/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTObject.h"
@class HKTPolicy,HKTCuePoint;

@interface HKTAdsConfriguration : HKTObject
@property (nonatomic, copy, readonly) HKTPolicy *policy;
@property (nonatomic, copy, readonly) NSURL *url;
@property (nonatomic, copy, readonly) NSArray <HKTCuePoint*> *cuePoints;
@end
