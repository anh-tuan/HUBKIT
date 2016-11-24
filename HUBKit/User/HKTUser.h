//
//  HKTUser.h
//  HUBKit
//
//  Created by Robert Wagstaff on 10/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTObject.h"

@interface HKTUser : HKTObject

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *givenName;
@property (nonatomic, copy, readonly) NSString *familyName;
@property (nonatomic, copy, readonly) NSString *currency;
@property (nonatomic, copy, readonly) NSString *provider;
@property (nonatomic, copy, readonly) NSString *credits;
@property (nonatomic, copy, readonly) NSDate *createdDate;
@property (nonatomic, copy, readonly) NSString *accessToken;
@property (nonatomic, copy, readonly) NSDictionary *subscription;
+ (NSDateFormatter*)dateFormatter;
+ (NSDateFormatter*)dateFormatterTimeZone;
@end
