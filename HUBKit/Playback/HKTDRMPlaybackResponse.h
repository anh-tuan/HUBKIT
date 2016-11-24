//
//  HKTDRMPlaybackResponse.h
//  HUBKit
//
//  Created by Robert Wagstaff on 24/09/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTObject.h"

@interface HKTDRMPlaybackResponse : HKTObject

@property (nonatomic, copy, readonly) NSString *assetID;
@property (nonatomic, copy, readonly) NSString *variant;

@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, copy, readonly) NSURL *redirectURL;

@property (nonatomic, readonly) BOOL storeLicense;


@end
