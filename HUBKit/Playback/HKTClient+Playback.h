//
//  HKTClient+Playback.h
//  HUBKit
//
//  Created by Robert Wagstaff on 23/09/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTClient.h"
#import "HKTDRMPlaybackRequest.h"


///** The quality of the product. Currently just SD and HD. */


@interface HKTClient (Playback)

/**
 *  Authorize playback for the current user, based on the product, variant and device
 *
 *  @param drmPlaybackRequest A request object wrapping all the required information
 *
 *  @return  RACSignal that contains a HKTDRMPlaybackResponse
 */
- (RACSignal*)authorizeDRMPlaybackWithRequest:(HKTDRMPlaybackRequest*)drmPlaybackRequest;


/**
 *  List the streams available for a product, for the current user
 *
 *  @param productID  the ID of the product
 *  @param parameters An HKTVariant to represent the quality of the video
 *
 *  @return RACSignal that contains an NSData to represent the returned XML
 */
- (RACSignal*)fetchStreamsForProductID:(NSString*)productID withVariant:(HKTVariant)variant;

/**
 *  Showing advertising config for a product, need using it before you play the product
 *
 *  @param productID the ID of the product
 *
 *  @return RACSignal that contains an HKTAdsConfriguration
 */
- (RACSignal*)advertisingConfigForProductID:(NSString*)productID;
@end
