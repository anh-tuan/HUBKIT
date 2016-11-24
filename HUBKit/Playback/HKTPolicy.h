//
//  HKTAdvertisingConfig.h
//  HUBKit
//
//  Created by Chao Ruan on 9/10/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTObject.h"

@interface HKTPolicy : HKTObject
@property (nonatomic, copy, readonly) NSString *provider;
@property (nonatomic, copy, readonly) NSArray *initialPolicy;
@property (nonatomic, copy, readonly) NSArray *recurringPolicy;
@end
