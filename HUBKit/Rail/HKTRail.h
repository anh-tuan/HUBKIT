//
//  HKTRail.h
//  HUBKit
//
//  Created by Chao Ruan on 10/11/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTObject.h"

@interface HKTRail : HKTObject
@property (nonatomic, copy, readonly) NSString *theme;
@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, readonly) NSInteger limit;
@property (nonatomic, copy, readonly) NSNumber *collectionID;
@property (nonatomic, copy, readonly) NSArray  *items;
@end
