//
//  HKTClient+Rail.m
//  HUBKit
//
//  Created by Chao Ruan on 10/11/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTClient+Rail.h"
#import "HKTRequestParameter.h"
#import "HKTListResponse+Parsing.h"
#import "RACSignal+HKTClientAdditions.h"
@implementation HKTClient (Rail)

-(RACSignal*) fetchAllRailsWithContentType:(HKTProductType)type
{
    return [self fetchAllRailsWithParameters:nil type:type];
}

- (RACSignal*) fetchAllRailsWithParameters:(NSArray<HKTRequestParameter*>*)parameters type:(HKTProductType)type
{
    //NSString *path = [NSString stringWithFormat:@"content/rails/%@",[self pathForType:type]];
    NSString *path = [NSString stringWithFormat:@"data/rails/%@",[self pathForType:type]];
    NSDictionary *param = [HKTRequestParameter dictionaryForRequestParameters:parameters];
    // Need update for iOS
    param = [param mtl_dictionaryByAddingEntriesFromDictionary:@{@"device":@"ios"}];
    NSURLRequest *request = [self createRequestForResource:path
                                                    method:URLRequestMethodTypeGET
                                                parameters:param];
    NSLog(@"fetchAllRailsWithParameters.request: %@",request);
    return [[self enqueueRequest:request resultClass:HKTListResponse.class] hkt_parsedRailsList];
}

- (NSString*)pathForType:(HKTProductType)type
{
    switch (type) {
        case HKTProductTypeSVOD:
            return @"buffet";
        case HKTProductTypeTVOD:
            return @"cineplex";
        default:
            return @"go";
            break;
    }
}
@end
