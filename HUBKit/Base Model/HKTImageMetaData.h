//
//  HKTImage.h
//  HUBKit
//
//  Created by Robert Wagstaff on 9/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface HKTImageMetaData : MTLModel <MTLJSONSerializing>


@property (nonatomic, copy, readonly) NSNumber* width;
@property (nonatomic, copy, readonly) NSNumber* height;
@property (nonatomic, copy, readonly) NSURL* url;

@end
