//
//  HKTClient.h
//  HUBKit
//
//  Created by Robert Wagstaff on 8/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <AFNetworking/AFNetworking.h>

extern NSString* const HUBKitBaseURL;

typedef NS_ENUM(NSUInteger, URLRequestMethodType) {
    URLRequestMethodTypeGET,
    URLRequestMethodTypePUT,
    URLRequestMethodTypePOST,
    URLRequestMethodTypeDELETE
};

extern NSString * const HKTClientErrorDomain;
extern NSString * const HKTClientErrorRequestURLKey;
extern NSString * const HKTClientErrorHTTPStatusCodeKey;

extern const NSInteger HKTClientErrorAuthenticationFailed;
extern const NSInteger HKTClientErrorConnectionFailed;
extern const NSInteger HKTClientErrorJSONParsingFailed;
extern const NSInteger HKTClientErrorBadRequest;
extern const NSInteger HKTClientErrorRequestForbidden;

@interface HKTClient : AFHTTPSessionManager

@property (nonatomic, readonly) AFHTTPRequestSerializer <AFURLRequestSerialization> * xmlRequestSerializer;

/**
 *  Creates a new instance of HKTClient, set up with the correct headers and base URL
 *
 *  @param APIKey the unique API key provied to you by Movideo. You can see your account’s API keys in the admin dashboard.
 *  contact support@movideo.com for more information
 *
 *  @return a new instance of HKTClient
 */
+(instancetype) clientWithAPIKey:(NSString*)APIKey;

// Creates a mutable URL request, which when sent will conditionally fetch the
// latest data from the server.
//
// method          - The HTTP method to use in the request
//                   (e.g., "GET" or "POST").
// path            - The path to request, relative to the base API endpoint.
//                   This path should _not_ begin with a forward slash.
// parameters      - HTTP parameters to encode and send with the request.
//
// Returns an NSMutableURLRequest.
//
- (NSMutableURLRequest *)createRequestForResource:(NSString *)resource method:(URLRequestMethodType)method parameters:(NSDictionary *)parameters;

// Creates a mutable URL request, which when sent will conditionally fetch the
// latest xml data from the server.
//
// method          - The HTTP method to use in the request
//                   (e.g., "GET" or "POST").
// path            - The path to request, relative to the base API endpoint.
//                   This path should _not_ begin with a forward slash.
// parameters      - HTTP parameters to encode and send with the request.
//
// Returns an NSMutableURLRequest.
//

- (NSMutableURLRequest *)createRequestForXMLResource:(NSString *)resource method:(URLRequestMethodType)method parameters:(NSDictionary *)parameters;
/**
 *  Enqueues a request to be sent to the server.
 *
 *  @param request     the request required
 *  @param resultClass the expected return object
 *
 *  @return A RACSignal that sends the returned json transformed to the supplied resultClass
 */
- (RACSignal *)enqueueRequest:(NSURLRequest *)request resultClass:(Class)resultClass;

/**
 *  Enqueues an request to be sent to the server. Used for playback requests.
 *
 *  @param request     the request required
 *
 *  @return A RACSignal that sends the returned XML transformed to an NSData
 */
- (RACSignal *)enqueueXMLRequest:(NSURLRequest *)request;

- (NSMutableURLRequest *)createRequestForXMLResource:(NSString *)resource method:(URLRequestMethodType)method urlString:(NSString*)urlString parameters:(NSDictionary *)parameters;
- (NSMutableURLRequest *)createRequestForJSONResource:(NSString *)resource method:(URLRequestMethodType)method parameters:(NSDictionary *)parameters;

@end
