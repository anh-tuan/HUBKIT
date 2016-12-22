//
//  HKTClient.m
//  HUBKit
//
//  Created by Robert Wagstaff on 8/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTClient.h"
#import "HKTObject.h"
#import "HKTClient+Authentication.h"
#import <Mantle/Mantle.h>

//NSString* const HUBKitBaseURL = @"http://danet.ap-southeast-1.elasticbeanstalk.com/";
//NSString* const HUBKitBaseURL = @"http://danetmiddleware.54aqfb5idd.ap-southeast-1.elasticbeanstalk.com/";
//NSString* const HUBKitBaseURL = @"http://danetmiddleware-prod.ap-southeast-1.elasticbeanstalk.com/";
//NSString* const HUBKitBaseURL = @"http://alpha.danet.vn/api/";
NSString* const HUBKitBaseURL = @"http://api.danet.vn/";
//http://api.danet.vn/playlist/list/1

NSString * const HKTClientErrorDomain = @"HKTClientErrorDomain";
NSString * const HKTClientErrorRequestURLKey = @"HKTClientErrorRequestURLKey";
NSString * const HKTClientErrorHTTPStatusCodeKey = @"HKTClientErrorHTTPStatusCodeKey";

const NSInteger HKTClientErrorAuthenticationFailed = 666;
const NSInteger HKTClientErrorConnectionFailed = 668;
const NSInteger HKTClientErrorJSONParsingFailed = 669;
const NSInteger HKTClientErrorBadRequest = 670;
const NSInteger HKTClientErrorRequestForbidden = 674;

@interface HKTClient ()

@property (nonatomic, strong) AFHTTPRequestSerializer <AFURLRequestSerialization> * xmlRequestSerializer;

@end

@implementation HKTClient

#pragma mark - Initialize
+(instancetype) clientWithAPIKey:(NSString*)APIKey {
    HKTClient *client = [[self alloc] initWithBaseURL:[NSURL URLWithString:HUBKitBaseURL]];
    client.requestSerializer = [AFJSONRequestSerializer serializer];
    [client configureRequestSerializers:APIKey];
    return client;
}

#pragma mark - Private method
/** Configure headers for HubKit API */
- (void)configureRequestSerializers:(NSString*)APIKey
{
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:@"1.0.0" forHTTPHeaderField:@"Movideo-API-Version"];
    [self.requestSerializer setAuthorizationHeaderFieldWithUsername:APIKey password:@""];
    
    self.xmlRequestSerializer = [[AFHTTPRequestSerializer alloc] init];
    [self.xmlRequestSerializer setValue:@"application/LLl+xml" forHTTPHeaderField:@"Content-Type"];
    [self.xmlRequestSerializer setValue:@"application/smil+xml" forHTTPHeaderField:@"Accept"];
    [self.xmlRequestSerializer setValue:@"1.0.0" forHTTPHeaderField:@"Movideo-API-Version"];
    [self.xmlRequestSerializer setValue:@"0" forHTTPHeaderField:@"Content-Length"];
    [self.xmlRequestSerializer setAuthorizationHeaderFieldWithUsername:APIKey password:@""];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    if (accessToken) {
        [self.xmlRequestSerializer setValue:accessToken forHTTPHeaderField:@"Movideo-Auth"];
    }
}

#pragma mark - Request Creation
- (NSMutableURLRequest *)createRequestForResource:(NSString *)resource method:(URLRequestMethodType)method parameters:(NSDictionary *)parameters
{
    NSParameterAssert(resource != nil);
    
    NSMutableDictionary *params = (parameters != nil) ? parameters.mutableCopy : @{}.mutableCopy;
    
    params = params.count == 0 ? nil : params;
    NSString *requestMethod = [HKTClient requestMethodNameForType:method];
    
    NSString *resourceURLString = [[NSURL URLWithString:resource relativeToURL:self.baseURL] absoluteString];
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:requestMethod URLString:resourceURLString parameters:params error:nil];
    
    
    return request;
}

- (NSMutableURLRequest *)createRequestForXMLResource:(NSString *)resource method:(URLRequestMethodType)method parameters:(NSDictionary *)parameters
{
    NSParameterAssert(resource != nil);
    
    NSMutableDictionary *params = (parameters != nil) ? parameters.mutableCopy : @{}.mutableCopy;
    
    params = params.count == 0 ? nil : params;
    NSString *requestMethod = [HKTClient requestMethodNameForType:method];
    
    NSString *resourceURLString = [[NSURL URLWithString:resource relativeToURL:self.baseURL] absoluteString];
    NSMutableURLRequest *request = [self.xmlRequestSerializer requestWithMethod:requestMethod URLString:resourceURLString parameters:params error:nil];
    
    return request;
}
- (NSMutableURLRequest *)createRequestForJSONResource:(NSString *)resource method:(URLRequestMethodType)method parameters:(NSDictionary *)parameters
{
    NSString *bhd_api_key = @"457";
    NSParameterAssert(resource != nil);
    AFJSONRequestSerializer *xmlRequestSerializer = [[AFJSONRequestSerializer alloc] init];
    [xmlRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [xmlRequestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [xmlRequestSerializer setValue:@"1.0.0" forHTTPHeaderField:@"Movideo-API-Version"];
    [xmlRequestSerializer setValue:@"0" forHTTPHeaderField:@"Content-Length"];
    [xmlRequestSerializer setAuthorizationHeaderFieldWithUsername:bhd_api_key password:@""];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    if (accessToken) {
        [xmlRequestSerializer setValue:accessToken forHTTPHeaderField:@"Movideo-Auth"];
    }
    NSMutableDictionary *params = (parameters != nil) ? parameters.mutableCopy : @{}.mutableCopy;
    
    params = params.count == 0 ? nil : params;
    NSString *requestMethod = [HKTClient requestMethodNameForType:method];
    
    NSString *resourceURLString = [[NSURL URLWithString:resource relativeToURL:self.baseURL] absoluteString];
    NSMutableURLRequest *request = [xmlRequestSerializer requestWithMethod:requestMethod URLString:resourceURLString parameters:params error:nil];
    
    return request;
}
- (NSMutableURLRequest *)createRequestForXMLResource:(NSString *)resource method:(URLRequestMethodType)method urlString:(NSString*)urlString parameters:(NSDictionary *)parameters
{
    NSParameterAssert(resource != nil);
    
    NSMutableDictionary *params = (parameters != nil) ? parameters.mutableCopy : @{}.mutableCopy;
    
    params = params.count == 0 ? nil : params;
    NSString *requestMethod = [HKTClient requestMethodNameForType:method];
    
    NSString *resourceURLString = [[NSURL URLWithString:resource relativeToURL:[NSURL URLWithString:urlString]] absoluteString];
    NSMutableURLRequest *request = [self.xmlRequestSerializer requestWithMethod:requestMethod URLString:resourceURLString parameters:params error:nil];
    
    return request;
}
#pragma mark URLRequestMethodType
+ (NSArray *)requestMethods
{
    static NSMutableArray * _methods = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _methods = [NSMutableArray arrayWithCapacity:4];
        [_methods insertObject:@"GET" atIndex:URLRequestMethodTypeGET];
        [_methods insertObject:@"PUT" atIndex:URLRequestMethodTypePUT];
        [_methods insertObject:@"POST" atIndex:URLRequestMethodTypePOST];
        [_methods insertObject:@"DELETE" atIndex:URLRequestMethodTypeDELETE];
    });
    return _methods;
}

+ (NSString *)requestMethodNameForType:(URLRequestMethodType)type
{
    return [[self requestMethods] objectAtIndex:type];
}

#pragma mark - Enqueue Request
- (RACSignal *)enqueueRequest:(NSURLRequest *)request resultClass:(Class)resultClass
{
    RACSignal* enqueRequestSignal = [[self enqueueRequest:request] flattenMap:^RACStream *(RACTuple *responseTuple) {
        id responseObject = [responseTuple second];
        return [self parsedResponseOfClass:resultClass fromJSON:responseObject];
    }];
    
    return [self refreshTokenIfRequiredForEnqueRequestSignal:enqueRequestSignal];
}

- (RACSignal *)enqueueRequest:(NSURLRequest *)request
{
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSLog(@"enqueueRequest request: %@",request);
        
        NSURLSessionDataTask __block *dataTask = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response ?: (NSHTTPURLResponse *)dataTask.response;
            //NSLog(@"[%@ %d %s] enqueueRequest responseObject: %@", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] lastPathComponent], __LINE__, __PRETTY_FUNCTION__,responseObject);
            if (! error) {
                [subscriber sendNext:RACTuplePack(httpResponse, responseObject)];
                [subscriber sendCompleted];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"resetMenu" object:nil];
            } else {
                NSLog(@"%@ %@ %@ => FAILED WITH %li", request.HTTPMethod, request.URL, request.allHTTPHeaderFields, (long)httpResponse.statusCode);
                //[subscriber sendError:[self.class HUBKitErrorForURLResponse:dataTask.response error:dataTask.error]];
                [subscriber sendNext:RACTuplePack(httpResponse, responseObject)];
                [subscriber sendCompleted];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"resetMenu" object:nil];
            }
        }];
        
        [dataTask resume];
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
        
    }]
                         doError:^(NSError *error) {
                             NSLog(@"Enqueue request error %@",error);
                         }];
    
    return [signal setNameWithFormat:@"-enqueueRequest: %@", request];
}

-(RACSignal*) enqueueXMLRequest:(NSURLRequest *)request
{
    RACSignal *enqueueXMLRequestSignal = [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:RACTuplePack(operation.response.allHeaderFields,responseObject)];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            [subscriber sendError:[self.class HUBKitErrorForURLResponse:operation.response error:error]];
        }];
        
        [operation start];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }]
                                           doError:^(NSError *error) {
                                               NSLog(@"Enqueue XMLrequest error %@",error);
                                           }] setNameWithFormat:@"-enqueueXMLRequest: %@", request];
    
    return [self refreshTokenIfRequiredForEnqueRequestSignal:enqueueXMLRequestSignal];
}

-(RACSignal*) refreshTokenIfRequiredForEnqueRequestSignal:(RACSignal*)enqueueRequestSignal
{
    return [enqueueRequestSignal catch:^RACSignal *(NSError *error) {
        if ([error.userInfo[HKTClientErrorHTTPStatusCodeKey]  isEqual: @403]) {
            return [enqueueRequestSignal retry:2];
        }
        if ([error.userInfo[HKTClientErrorHTTPStatusCodeKey]  isEqual: @401]) {
            return [[self refreshTokenForCurrenUser] concat:enqueueRequestSignal];
        }
        return [RACSignal error:error];
    }];
}

#pragma mark - Response Parsing
- (RACSignal *)parsedResponseOfClass:(Class)resultClass fromJSON:(id)responseObject
{
    NSParameterAssert(resultClass == nil || [resultClass isSubclassOfClass:MTLModel.class]);
    
    return [RACSignal createSignal:^ id (id<RACSubscriber> subscriber) {
        void (^parseJSONDictionary)(NSDictionary *) = ^(NSDictionary *JSONDictionary) {
            if (resultClass == nil) {
                [subscriber sendNext:JSONDictionary];
                return;
            }
            
            NSError *error = nil;
            HKTObject *parsedObject = [MTLJSONAdapter modelOfClass:resultClass fromJSONDictionary:JSONDictionary error:&error];
            if (parsedObject == nil) {
                // Don't treat "no class found" errors as real parsing failures.
                // In theory, this makes parsing code forward-compatible with
                // API additions.
                if (![error.domain isEqual:MTLJSONAdapterErrorDomain] || error.code != MTLJSONAdapterErrorNoClassFound) {
                    [subscriber sendError:error];
                }
                
                return;
            }
            
            NSAssert([parsedObject isKindOfClass:HKTObject.class], @"Parsed model object is not an HKTObject: %@", parsedObject);
            
            if ([JSONDictionary objectForKey:@"success"]) {
                if (![[JSONDictionary objectForKey:@"success"] boolValue]) {
                    [subscriber sendError:nil];
                }else {
                    [subscriber sendNext:parsedObject];
                }
            }else {
                [subscriber sendNext:parsedObject];
            }
        };
        
        if ([responseObject isKindOfClass:NSArray.class]) {
            for (NSDictionary *JSONDictionary in responseObject) {
                if (![JSONDictionary isKindOfClass:NSDictionary.class]) {
                    NSString *failureReason = [NSString stringWithFormat:NSLocalizedString(@"Invalid JSON array element: %@", @""), JSONDictionary];
                    [subscriber sendError:[self parsingErrorWithFailureReason:failureReason]];
                    return nil;
                }
                
                parseJSONDictionary(JSONDictionary);
            }
            
            [subscriber sendCompleted];
        } else if ([responseObject isKindOfClass:NSDictionary.class]) {
            parseJSONDictionary(responseObject);
            [subscriber sendCompleted];
        } else if (responseObject != nil) {
            NSString *failureReason = [NSString stringWithFormat:NSLocalizedString(@"Response wasn't an array or dictionary (%@): %@", @""), [responseObject class], responseObject];
            [subscriber sendError:[self parsingErrorWithFailureReason:failureReason]];
        }
        
        return nil;
    }];
}

- (NSError *)parsingErrorWithFailureReason:(NSString *)localizedFailureReason
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[NSLocalizedDescriptionKey] = NSLocalizedString(@"Could not parse the service response.", @"");
    
    if (localizedFailureReason != nil) {
        userInfo[NSLocalizedFailureReasonErrorKey] = localizedFailureReason;
    }
    
    return [NSError errorWithDomain:HKTClientErrorDomain code:HKTClientErrorJSONParsingFailed userInfo:userInfo];
}

#pragma mark - Errors
+(NSError*) HUBKitErrorForURLResponse:(NSURLResponse*)URLResponse error:(NSError*)responseError {
    
    if ([responseError.domain isEqualToString:NSURLErrorDomain]) {
        return responseError;
    }
    
    NSInteger HTTPCode = [(NSHTTPURLResponse *)URLResponse statusCode];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    
    NSInteger errorCode;
    switch (HTTPCode) {
        case 401:
            errorCode = HKTClientErrorAuthenticationFailed;
            break;
            
        case 400:
            errorCode = HKTClientErrorBadRequest;
            break;
            
        case 403:
            errorCode = HKTClientErrorRequestForbidden;
            break;
        default:
            errorCode = HKTClientErrorConnectionFailed;
    }
    
    userInfo[HKTClientErrorHTTPStatusCodeKey] = @(HTTPCode);
    if ([URLResponse URL] != nil) userInfo[HKTClientErrorRequestURLKey] = [URLResponse URL];
    if (responseError != nil) userInfo[NSUnderlyingErrorKey] = responseError;
    
    return [NSError errorWithDomain:HKTClientErrorDomain code:errorCode userInfo:userInfo];
}

@end
