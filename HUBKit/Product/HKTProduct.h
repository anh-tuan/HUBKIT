//
//  HKTProduct.h
//  HUBKit
//
//  Created by Robert Wagstaff on 9/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTObject.h"
#import "HKTImageMetaData.h"
#import "HKTProductOffering.h"

@interface HKTProduct : HKTObject

@property (nonatomic, readonly) HKTContentType contentType;
@property (nonatomic, readonly) HKTProductType packageType;
@property (nonatomic, readonly) BOOL hasParent;
@property (nonatomic, readonly) BOOL hasChildren;
@property (nonatomic, readonly) BOOL favourited;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *productDescription;
@property (nonatomic, copy, readonly) NSNumber *duration;
@property (nonatomic, copy, readonly) id released;
@property (nonatomic, copy, readonly) NSString *classification;
@property (nonatomic, copy, readonly) NSString *trailer;
@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, copy, readonly) NSDate *modifiedAt;
@property (nonatomic, copy, readonly) NSArray *audioLanguages;
@property (nonatomic, copy, readonly) NSArray *subtitleLanguages;
@property (nonatomic, copy, readonly) NSArray *countries;
@property (nonatomic, copy, readonly) NSArray *genres;
@property (nonatomic, copy, readonly) NSArray *actors;
@property (nonatomic, copy, readonly) NSArray *directors;

@property (nonatomic, copy, readonly) NSArray<HKTImageMetaData*> *defaultImages;
@property (nonatomic, copy, readonly) NSArray<HKTImageMetaData*> *posterImages;
@property (nonatomic, copy, readonly) NSArray<HKTImageMetaData*> *backgroundImages;

@property (nonatomic, readonly) HKTImageMetaData* defaultImage;
@property (nonatomic, readonly) HKTImageMetaData* posterImage;
@property (nonatomic, readonly) HKTImageMetaData* backgroundImage;

@property (nonatomic, copy, readonly) NSArray *offerings;

@end
