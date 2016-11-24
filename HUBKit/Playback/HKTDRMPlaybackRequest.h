//
//  HKTDRMPlaybackRequest.h
//  HUBKit
//
//  Created by Robert Wagstaff on 23/09/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//


#import "HKTRequestParameter.h"

/**
 *  Model object used to encapsulate all the required fields for authorizing DRM playback. 
 userID, assetID and clientID are mandatory. Variant and sessionID are optional.
 */
@interface HKTDRMPlaybackRequest : NSObject

@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, copy, readonly) NSString *assetID;
@property (nonatomic, copy, readonly) NSString *clientID;

@property (nonatomic, copy, readonly) NSString *variant;
@property (nonatomic, copy, readonly) NSString *sessionID;


- (instancetype)initWithUserID:(NSString*)userID assetID:(NSString*)assettID clientID:(NSString*)clientID;
- (void) setVariant:(NSString *)variant;
- (void) setSessionID:(NSString *)sessionID;


@end
