//
//  HKTUser.m
//  HUBKit
//
//  Created by Robert Wagstaff on 10/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTUser.h"

@implementation HKTUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              @"identifier"     :   @"identifier",
              @"givenName"      :   @"given_name",
              @"familyName"     :   @"family_name",
              @"createdDate"    :   @"created_at",
              @"accessToken"    :   @"accessToken",
              @"provider"       :   @"provider",
              @"credits"        :   @"credits",
              @"currency"       :   @"currency",
              @"subscription"   :   @"subscription"
              }];
}

+ (NSDateFormatter*)dateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.locale = [NSLocale autoupdatingCurrentLocale];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    });
    return dateFormatter;
}
+ (NSDateFormatter*)dateFormatterTimeZone
{
    static NSDateFormatter *dateFormatterTimeZone = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatterTimeZone = [[NSDateFormatter alloc]init];
        dateFormatterTimeZone.locale = [NSLocale autoupdatingCurrentLocale];
        dateFormatterTimeZone.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    });
    return dateFormatterTimeZone;
}
+ (NSValueTransformer*)createdDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *string,BOOL *success, NSError **error) {
        return [self.dateFormatter dateFromString:string];
    } reverseBlock:^id(NSDate *date,BOOL *success, NSError **error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

@end
