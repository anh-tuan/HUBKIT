//
//  HKTProduct.m
//  HUBKit
//
//  Created by Robert Wagstaff on 9/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTProduct.h"

@interface HKTProduct ()
@property (nonatomic, strong) HKTImageMetaData* defaultImage;
@property (nonatomic, strong) HKTImageMetaData* posterImage;
@property (nonatomic, strong) HKTImageMetaData* backgroundImage;
@end

@implementation HKTProduct

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              @"contentType"        :   @"type",
              @"packageType"        :   @"package_type",
              @"hasParent"          :   @"has_parent",
              @"hasChildren"        :   @"has_children",
              @"title"              :   @"title",
              @"productDescription" :   @"description",
              @"duration"           :   @"duration",
              @"favourited"         :   @"favourited",
              @"released"           :   @"released",
              @"audioLanguages"     :   @"language.audios",
              @"subtitleLanguages"  :   @"language.subtitles",
              @"countries"          :   @"country",
              @"classification"     :   @"classification",
              @"genres"             :   @"genres",
              @"actors"             :   @"actors",
              @"directors"          :   @"directors",
              @"defaultImages"       :   @"image.profile.default", // TODO check definitions of images. Seems wrong
              @"posterImages"        :   @"image.profile.poster",
              @"backgroundImages"    :   @"image.profile.background",
              @"posterImagesURL"        :   @"poster",
              @"backgroundImagesURL"    :   @"background",
              @"createdAt"    :   @"created_at",
              @"modifiedAt"          :   @"modified_at",
              @"offerings"          :   @"offerings",
              @"trailer"            : @"trailer"
              }];
}
+ (NSDateFormatter*)dateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.locale = [NSLocale autoupdatingCurrentLocale];
        dateFormatter.dateFormat = @"yyyy-MM-DD'T'HH:mm:ss";
    });
    return dateFormatter;
}

+ (NSValueTransformer*)createdAtJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *string,BOOL *success, NSError **error) {
        return [self.dateFormatter dateFromString:string];
    } reverseBlock:^id(NSDate *date,BOOL *success, NSError **error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer*)modifiedAtJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *string,BOOL *success, NSError **error) {
        return [self.dateFormatter dateFromString:string];
    } reverseBlock:^id(NSDate *date,BOOL *success, NSError **error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer*)contentTypeJSONTransformer
{
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary
            :@{
               [HKTRequestParameter parameterValueForSingleContentType:HKTContentTypeMovie]      : @(HKTContentTypeMovie),
               [HKTRequestParameter parameterValueForSingleContentType:HKTContentTypeSeries]     : @(HKTContentTypeSeries),
               [HKTRequestParameter parameterValueForSingleContentType:HKTContentTypeSeason]     : @(HKTContentTypeSeason),
               [HKTRequestParameter parameterValueForSingleContentType:HKTContentTypeEpisode]    : @(HKTContentTypeEpisode),
               [HKTRequestParameter parameterValueForSingleContentType:HKTContentTypeNews]       : @(HKTContentTypeNews),
               [HKTRequestParameter parameterValueForSingleContentType:HKTContentTypeTrailer]    : @(HKTContentTypeTrailer),
               [HKTRequestParameter parameterValueForSingleContentType:HKTContentTypeCollection] : @(HKTContentTypeCollection),
               [HKTRequestParameter parameterValueForSingleContentType:HKTContentTypeClip]       : @(HKTContentTypeClip),
               [HKTRequestParameter parameterValueForSingleContentType:HKTContentTypeLive]       : @(HKTContentTypeLive)
               }
            defaultValue:@(HKTContentTypeUnknown) reverseDefaultValue:@""];
}
+ (NSValueTransformer*)packageTypeJSONTransformer
{
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary
            :@{@"AVOD": @(HKTProductTypeAVOD),
               @"TVOD": @(HKTProductTypeTVOD),
               @"SVOD": @(HKTProductTypeSVOD)
               }
            defaultValue:@(HKTProductTypeUnknown) reverseDefaultValue:@""];
}
+ (NSValueTransformer*)defaultImagesJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[MTLJSONAdapter modelsOfClass:HKTImageMetaData.class fromJSONArray:value error:nil]sortedArrayUsingComparator:^NSComparisonResult(HKTImageMetaData  *data1, HKTImageMetaData  *data2) {
            return [data1.width compare:data2.width];
        }];
    }];
}

+ (NSValueTransformer*)posterImagesJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[MTLJSONAdapter modelsOfClass:HKTImageMetaData.class fromJSONArray:value error:nil]sortedArrayUsingComparator:^NSComparisonResult(HKTImageMetaData  *data1, HKTImageMetaData  *data2) {
            return [data1.width compare:data2.width];
        }];
    }];
}


+ (NSValueTransformer*)backgroundImagesJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[MTLJSONAdapter modelsOfClass:HKTImageMetaData.class fromJSONArray:value error:nil]sortedArrayUsingComparator:^NSComparisonResult(HKTImageMetaData  *data1, HKTImageMetaData  *data2) {
            return [data1.width compare:data2.width];
        }];
    }];
}

+ (NSValueTransformer*)offeringsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:HKTProductOffering.class];

}

- (HKTImageMetaData*)defaultImage
{
    if (!_defaultImage) {
        
        _defaultImage = [self findBestImageInImages:self.defaultImages];
    }
    return _defaultImage;
}


- (HKTImageMetaData*)backgroundImage
{
    if (!_backgroundImage) {
        NSArray *images = [[self.backgroundImages.rac_sequence filter:^BOOL(HKTImageMetaData *data) {
            return [data.height doubleValue] / [data.width doubleValue] < 0.9;
        }] array];
        _backgroundImage = [self findBestImageInImages:images];
        // TODO: Remove this when backend fix the wrong image size on backgoround
//        _backgroundImage = [self findBestImageInImages:self.backgroundImages];
    }
    return _backgroundImage;
}


- (HKTImageMetaData*)posterImage
{
    if (!_posterImage) {
        NSArray *posterImages = [[self.posterImages.rac_sequence filter:^BOOL(HKTImageMetaData *data) {
            return [data.height doubleValue] / [data.width doubleValue] > 0.9;
        }] array];
        _posterImage = [self findBestImageInImages:posterImages];
    }
    return _posterImage;
}

- (HKTImageMetaData*)findBestImageInImages:(NSArray*)images
{
    HKTImageMetaData *defaultImage;
    defaultImage = [[[images.rac_sequence filter:^BOOL(HKTImageMetaData *data) {
        return data.width.integerValue >= 500;
        // TODO: Remove this when backend fix the wrong image size on backgoround
//        return data.width.integerValue >= UIScreen.mainScreen.bounds.size.width;
    }] array] firstObject];
    defaultImage = defaultImage ?: images.lastObject ;
    return defaultImage;
}


@end
