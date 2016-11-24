//
//  HKTDRMPlaybackRequest.m
//  HUBKit
//
//  Created by Robert Wagstaff on 23/09/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTDRMPlaybackRequest.h"

@interface HKTDRMPlaybackRequest()
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *assetID;
@property (nonatomic, copy) NSString *clientID;

@property (nonatomic, copy) NSString *variant;
@property (nonatomic, copy) NSString *sessionID;

@end

@implementation HKTDRMPlaybackRequest

- (instancetype)initWithUserID:(NSString*)userID assetID:(NSString*)assettID clientID:(NSString*)clientID
{
    self = [super init];
    if (self) {
        self.userID = userID;
        self.assetID = assettID;
        self.clientID = clientID;
    }
    return self;
}

@end
