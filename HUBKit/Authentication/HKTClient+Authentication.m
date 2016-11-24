//
//  HKTClient+Authentication.m
//  HUBKit
//
//  Created by Robert Wagstaff on 1/10/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTClient+Authentication.h"
#import "HKTUser.h"
#import "UICKeyChainStore.h"

#define DEFAULT_AUTH_PROVIDER @"movideo"
#define FACEBOOK_AUTH_PROVIDER @"facebook"

static NSString *kHKTUserPassword = @"HKTUserPassword";
static NSString *kHKTUserName = @"HKTUserName";
static NSString *kHKTToken = @"HKTToken";
static NSString *kHKTUser = @"HKTUser";

@implementation HKTClient (Authentication)

#pragma mark - HKTClient Signals

- (RACSignal*)signInWithFacebookUsingIdentifier:(NSString *)identifier
{
    
    NSDictionary* params = @{ @"provider"   :   FACEBOOK_AUTH_PROVIDER,
                              @"identifier" :   identifier,
                              };
    
    
    NSURLRequest *request = [self createRequestForResource:@"user/authenticate"
                                                      method:URLRequestMethodTypePOST
                                                  parameters:params];
    
    @weakify(self);
    return [[self enqueueRequest:request resultClass:HKTUser.class]
            flattenMap:^RACStream *(HKTUser* authenticatedUser) {
                @strongify(self);
                [self saveUserDetailToKeyChain:authenticatedUser password:nil];
                return [RACSignal empty];
            }];
    
}
- (RACSignal*)signInWithFacebookUsingAccessToken:(NSString *)accessToken
{
    
    NSDictionary* params = @{ @"provider"   :   FACEBOOK_AUTH_PROVIDER,
                              @"access_token" :   accessToken,
                              };
    
    
    NSURLRequest *request = [self createRequestForResource:@"user/authenticate"
                                                    method:URLRequestMethodTypePOST
                                                parameters:params];
    
    @weakify(self);
    return [[self enqueueRequest:request resultClass:HKTUser.class]
            flattenMap:^RACStream *(HKTUser* authenticatedUser) {
                @strongify(self);
                [self saveUserDetailToKeyChain:authenticatedUser password:nil];
                return [RACSignal empty];
            }];
    
}

- (RACSignal*)signUpAccountWithDic:(NSDictionary*)dict
{
    
//    NSDictionary* params = @{ @"provider"   :   DEFAULT_AUTH_PROVIDER,
//                              @"access_token" :   accessToken,
//                              };
    
    
    NSURLRequest *request = [self createRequestForResource:@"user"
                                                    method:URLRequestMethodTypePOST
                                                parameters:dict];
    
    @weakify(self);
    return [[self enqueueRequest:request resultClass:HKTUser.class]
            flattenMap:^RACStream *(HKTUser* authenticatedUser) {
                @strongify(self);
                [self saveUserDetailToKeyChain:authenticatedUser password:nil];
                return [RACSignal empty];
            }];
    
}

- (RACSignal*) signOutCurrentUser
{
    //TODO: Endpoint is not available yet. Just reusing authenticate endpoint for now and discarding the result.
    NSURLRequest *request = [self createRequestForResource:@"user/authenticate"
                                                      method:URLRequestMethodTypeGET
                                                  parameters:nil];
    return [[self enqueueRequest:request resultClass:HKTUser.class]
            flattenMap:^RACStream *(id value) {
                UICKeyChainStore *keychain = [UICKeyChainStore keyChainStore];
                [keychain removeAllItems];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accessToken"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutSuccess" object:nil];
                [self.requestSerializer setValue:nil forHTTPHeaderField:@"Movideo-Auth"];
                [self.xmlRequestSerializer setValue:nil forHTTPHeaderField:@"Movideo-Auth"];
                return [RACSignal empty];
            }];
}

#pragma mark - Authentication

- (RACSignal*)signInWithIdentifier:(NSString *)identifier password:(NSString *)password
{
    NSDictionary* params;
    if (password) {
        params = @{ @"provider"   :   DEFAULT_AUTH_PROVIDER,
                    @"identifier" :   identifier,
                    @"password"   :   password,
                    };
    }else {
        params = @{ @"provider"   :   DEFAULT_AUTH_PROVIDER,
                    @"identifier" :   identifier,
                    };
        NSLog(@"password nil");
    }
    
    NSURLRequest *request = [self createRequestForResource:@"user/authenticate"
                                                      method:URLRequestMethodTypePOST
                                                  parameters:params];
    @weakify(self);
    return [[self enqueueRequest:request resultClass:HKTUser.class]
            flattenMap:^RACStream *(HKTUser* authenticatedUser) {
                @strongify(self);
                [self saveUserDetailToKeyChain:authenticatedUser password:password];
                return [RACSignal empty];
            }];
}

- (void)saveUserDetailToKeyChain:(HKTUser*)user password:(NSString *)password
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStore];
    [keychain removeAllItems];
    [keychain setString:user.identifier forKey:kHKTUserName];
    [keychain setString:user.accessToken forKey:kHKTToken];
    if (password) {
        [keychain setString:password forKey:kHKTUserPassword];
    }
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    [keychain setData:userData forKey:kHKTUser];
    [self.requestSerializer setValue:user.accessToken forHTTPHeaderField:@"Movideo-Auth"];
    [self.xmlRequestSerializer setValue:user.accessToken forHTTPHeaderField:@"Movideo-Auth"];
    if (user.accessToken) {
        [[NSUserDefaults standardUserDefaults] setObject:user.accessToken forKey:@"accessToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (RACSignal*)refreshTokenForCurrenUser
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStore];
    HKTUser *user = [HKTClient currentSavedUser];
    if (!user) { return [RACSignal empty]; }
   
    if ([user.provider isEqualToString:DEFAULT_AUTH_PROVIDER]) {
        NSString *password = [keychain stringForKey:kHKTUserPassword];
        return [self signInWithIdentifier:user.identifier password:password];
    } else {
        return [self signInWithFacebookUsingIdentifier:user.identifier];
    }
}

+ (HKTUser*)currentSavedUser
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStore];
    NSData *userData = [keychain dataForKey:kHKTUser];
    HKTUser *user = nil;
    if (userData) {
        user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    }
    return user;
}

@end
