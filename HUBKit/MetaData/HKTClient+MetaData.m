//
//  HKTClient+MetaData.m
//  HUBKit
//
//  Created by Infosys on 24/11/15.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTClient+MetaData.h"
#import "HKTListResponse.h"
#import "RACSignal+HKTClientAdditions.h"

@implementation HKTClient (MetaData)

- (RACSignal*)fetchGenresWithContentTypeOptions:(HKTContentType)contentTypeOptions
{
    HKTRequestParameter* parameter = [HKTRequestParameter parameterWithContentTypeOptions:contentTypeOptions];
    
    NSURLRequest *request = [self createRequestForResource:@"metadata/genres"
                                                    method:URLRequestMethodTypeGET
                                                parameters:[HKTRequestParameter dictionaryForRequestParameters:@[parameter]]];
    
    return [[self enqueueRequest:request resultClass:HKTListResponse.class] hkt_parsedMetaData];
}

- (RACSignal*)fetchCountriesWithContentTypeOptions:(HKTContentType)contentTypeOptions
{
    HKTRequestParameter* parameter = [HKTRequestParameter parameterWithContentTypeOptions:contentTypeOptions];
    
    NSURLRequest *request = [self createRequestForResource:@"metadata/countries"
                                                    method:URLRequestMethodTypeGET
                                                parameters:[HKTRequestParameter dictionaryForRequestParameters:@[parameter]]];
    
    return [[self enqueueRequest:request resultClass:HKTListResponse.class] hkt_parsedMetaData];
}

@end
