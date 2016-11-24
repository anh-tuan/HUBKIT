//
//  HKTClient+Playback.m
//  HUBKit
//
//  Created by Robert Wagstaff on 23/09/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTClient+Playback.h"
#import "HKTClient.h"
#import "HKTRequestParameter.h"
#import "HKTDRMPlaybackResponse.h"
#import "HKTAdsConfriguration.h"

@implementation HKTClient (Playback)

- (RACSignal*)authorizeDRMPlaybackWithRequest:(HKTDRMPlaybackRequest*)drmPlaybackRequest
{
    
    NSString *path = [NSString stringWithFormat:@"right/%@/asset/%@", drmPlaybackRequest.userID, drmPlaybackRequest.assetID];
    NSDictionary* parameters = @{
                                 @"client_id"    : drmPlaybackRequest.clientID ? : @"",
                                 @"variant"      : drmPlaybackRequest.variant ? : @"",
                                 @"session_id"   : drmPlaybackRequest.sessionID ? : @""
                                 };
    
    NSURLRequest *request = [self createRequestForResource:path
                                                    method:URLRequestMethodTypeGET
                                                parameters:parameters];
    
    return [self enqueueRequest:request resultClass:HKTDRMPlaybackResponse.class];
}

- (RACSignal*)fetchStreamsForProductID:(NSString*)productID withVariant:(HKTVariant)variant
{
    NSString *path = [NSString stringWithFormat:@"products/%@/playback/streams", productID];
    NSString *deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSDictionary* requestParams =@{
                                   @"device_id"   : deviceID,
                                   @"device_type" : @"ios",
                                   @"variant"     : [HKTRequestParameter parameterValueForVariant:variant]
                                   };
    
    NSURLRequest *request = [self createRequestForXMLResource:path
                                                       method:URLRequestMethodTypeGET
                                                   parameters:requestParams];
    return [self enqueueXMLRequest:request];
}

- (RACSignal*)advertisingConfigForProductID:(NSString*)productID
{
    NSString *path = [NSString stringWithFormat:@"products/%@/ads", productID];
    NSURLRequest *request = [self createRequestForResource:path
                                                    method:URLRequestMethodTypeGET
                                                parameters:nil];
    return [self enqueueRequest:request resultClass:HKTAdsConfriguration.class];
}

@end
