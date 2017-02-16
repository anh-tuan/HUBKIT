//
//  HKTClient+Authentication.h
//  HUBKit
//
//  Created by Robert Wagstaff on 1/10/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTClient.h"

@class HKTUser;

@interface HKTClient (Authentication)

- (RACSignal*)signInWithFacebookUsingIdentifier:(NSString *)identifier;

- (RACSignal*)signOutCurrentUser;

- (RACSignal*)signInWithFacebookUsingAccessToken:(NSString *)accessToken;

- (RACSignal*)signUpAccountWithDic:(NSDictionary*)dict;

- (RACSignal*)forgotAccountWithDic:(NSDictionary*)dict;

- (RACSignal*)signInWithIdentifier:(NSString *)identifier password:(NSString *)password;

- (void)saveUserDetailToKeyChain:(HKTUser*)user password:(NSString *)password;

- (RACSignal*)refreshTokenForCurrenUser;

+ (HKTUser*)currentSavedUser;
@end
