//
//  HKTCuePoint.h
//  HUBKit
//
//  Created by Chao Ruan on 9/10/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTObject.h"
typedef NS_ENUM(NSUInteger, HKTCuePointType) {
    HKTCuePointTypeUnknown,
    HKTCuePointTypeSeconds,
    HKTCuePointTypePercentage,
};
@interface HKTCuePoint : HKTObject
@property (nonatomic, readonly) HKTCuePointType type;
@property (nonatomic, readonly) NSInteger value;
@end
