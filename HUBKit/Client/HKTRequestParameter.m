//
//  HKTRequestParameter.m
//  HUBKit
//
//  Created by Robert Wagstaff on 10/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTRequestParameter.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface HKTRequestParameter()
/**
 *  The Type of the HTTP request parameter. Maps to the correct request key
 */
@property(nonatomic) HKTRequestParameterType requestParameterType;
/**
 *  The value of the the HTTP request parameter
 */
@property(nonatomic, copy) id requestParameterValue;

@end

@implementation HKTRequestParameter

//MARK: - Public methods
- (instancetype)initWithType:(HKTRequestParameterType)type value:(id)value
{
    self = [super init];
    if (self) {
        self.requestParameterType = type;
        self.requestParameterValue = value;
    }
    return self;
}

+(HKTRequestParameter*) parameterWithPage:(NSNumber*)page
{
    if (page == nil || [page intValue] < 0) {return nil;}
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypePage value:page];
}

+(HKTRequestParameter*) parameterWithLimit:(NSNumber*)limit
{
    if (limit == nil || [limit intValue] < 0) {return nil;}
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypeLimit value:limit];
}

+(HKTRequestParameter*) parameterWithContentTypeOptions:(HKTContentType)contentTypeOptions
{
    if (contentTypeOptions == HKTContentTypeUnknown) {return nil;}
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypeContentTypes value:[self parameterValuesArrayForContentTypeOptions:contentTypeOptions]];
}

+(HKTRequestParameter*) parameterWithTypesOptions:(HKTContentType)typeOptions
{
    if (typeOptions == HKTContentTypeUnknown) {return nil;}
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypeTypes value:[self parameterValuesArrayForTypeOptions:typeOptions]];
}

+(HKTRequestParameter*) parameterWithProductTypeOptions:(HKTProductType)productTypeOptions
{
    if (productTypeOptions == HKTProductTypeUnknown) {return nil;}
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypeProductTypes value:[self parameterValuesArrayForProductTypeOptions:productTypeOptions]];
}
+(HKTRequestParameter*) parameterWithExcludedContentTypeOptions:(HKTContentType)contentTypeOptions
{
    if (contentTypeOptions == HKTContentTypeUnknown) {return nil;}
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypeExcludeContentTypes value:[self parameterValuesArrayForContentTypeOptions:contentTypeOptions]];
}

+(HKTRequestParameter*) parameterWithGenres:(NSArray<NSString*>*)genres
{
    if (![self isValidArray:genres forExpectedContentType:NSString.class]) { return nil; }
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypeGenres value:genres];
}

+(HKTRequestParameter*) parameterWithOriginCountries:(NSArray<NSString*>*)originCountries
{
    if (![self isValidArray:originCountries forExpectedContentType:NSString.class]) { return nil; }
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypeOriginCountries value:originCountries];
}

+(HKTRequestParameter*) parameterWithMinYear:(NSNumber*)minYear
{
    if (minYear == nil) { return nil; }
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypeMinYear value:minYear];
}

+(HKTRequestParameter*) parameterWithMaxYear:(NSNumber*)maxYear
{
    if (maxYear == nil) { return nil; }
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypeMaxYear value:maxYear];
}

+(HKTRequestParameter*) parameterWithPeople:(NSArray<NSString*>*)people
{
    if (![self isValidArray:people forExpectedContentType:NSString.class]) { return nil; }
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypePeople value:people];
}

+(HKTRequestParameter*) parameterWithRatings:(NSArray<NSString*>*)ratings
{
    if (![self isValidArray:ratings forExpectedContentType:NSString.class]) { return nil; }
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypeRatings value:ratings];
}
+(HKTRequestParameter*) parameterWithAudios:(NSArray<NSString*>*)audios
{
    if (![self isValidArray:audios forExpectedContentType:NSString.class]) { return nil; }
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypeAudios value:audios];
}

+(HKTRequestParameter*) parameterWithSubtitles:(NSArray<NSString*>*)subtitles
{
    if (![self isValidArray:subtitles forExpectedContentType:NSString.class]) { return nil; }
    return [[HKTRequestParameter alloc] initWithType:HKTRequestParameterTypeSubtitles value:subtitles];
}

+(NSDictionary*) dictionaryForRequestParameters:(NSArray*)requestParameters {
    NSMutableDictionary* paramsDictionary= [[NSMutableDictionary alloc] init];

    for (HKTRequestParameter* requestParameter in requestParameters) {
        NSString* parameterKey = [self parameterKeyForRequestParameterType:requestParameter.requestParameterType];
        [paramsDictionary setObject:requestParameter.requestParameterValue forKey:parameterKey];
    }
    return [paramsDictionary copy];
}

#pragma mark - Helper methods
+(BOOL)isValidArray:(NSArray*)array forExpectedContentType:(Class)class
{
    NSPredicate *validationPredicate = [NSPredicate predicateWithFormat:@"self isKindOfClass: %@", class];
    return ([array count] != 0 && [array filteredArrayUsingPredicate:validationPredicate].count == array.count);
}

+(NSString*)parameterKeyForRequestParameterType:(HKTRequestParameterType)paramaterType {
    switch (paramaterType) {
        case HKTRequestParameterTypePage:
            return @"page";
            break;
        case HKTRequestParameterTypeLimit:
            return @"limit";
            break;
        case HKTRequestParameterTypeContentTypes:
            return @"content_type";
            break;
        case HKTRequestParameterTypeTypes:
            return @"type";
            break;
        case HKTRequestParameterTypeProductTypes:
            return @"offerings";
            break;
        case HKTRequestParameterTypeExcludeContentTypes:
            return @"exclude_types";
            break;
        case HKTRequestParameterTypeGenres:
            return @"genres";
            break;
        case HKTRequestParameterTypeOriginCountries:
            return @"origin_countries";
            break;
        case HKTRequestParameterTypeMinYear:
            return @"min_year";
            break;
        case HKTRequestParameterTypeMaxYear:
            return @"max_year";
            break;
        case HKTRequestParameterTypePeople:
            return @"people";
            break;
        case HKTRequestParameterTypeRatings:
            return @"ratings";
            break;
        case HKTRequestParameterTypeAudios:
            return @"audios";
            break;
        case HKTRequestParameterTypeSubtitles:
            return @"subtitles";
            break;
        default:
            return nil;
    }
}

#pragma mark HKTContentType helpers
/**
 *  Converts an HKTContentType NS_OPTIONS into an array of the appropriate request value strings 
 *  e.g. an input of HKTContentTypeMovie | HKTContentTypeTrailer return @[@"movie", @"trailer"]
 *
 *  @param contentTypeOptions an HKTContentType NS_OPTIONS
 *
 *  @return an array of the appropriate HKTContentType request value strings
 */
+(NSArray<NSString*>*)parameterValuesArrayForContentTypeOptions:(HKTContentType)contentTypeOptions
{
    NSMutableArray *paramValueArray = [[NSMutableArray alloc] init];
    for (NSUInteger currentBit=0; currentBit < kBitsUsedByHKTContentTypeOptions; currentBit++) {
        NSUInteger bitValueToCheck = 1 << currentBit;
        if (contentTypeOptions & bitValueToCheck) {
            HKTContentType singleContentType = 1 << currentBit;
            [paramValueArray addObject:[self parameterValueForSingleContentType:singleContentType]];
        }
    }
    return [paramValueArray copy];
}

+(NSArray<NSString*>*)parameterValuesArrayForTypeOptions:(HKTContentType)typeOptions
{
    NSMutableArray *paramValueArray = [[NSMutableArray alloc] init];
    for (NSUInteger currentBit=0; currentBit < kBitsUsedByHKTContentTypeOptions; currentBit++) {
        NSUInteger bitValueToCheck = 1 << currentBit;
        if (typeOptions & bitValueToCheck) {
            HKTContentType singleContentType = 1 << currentBit;
            [paramValueArray addObject:[self parameterValueForSingleContentType:singleContentType]];
        }
    }
    return [paramValueArray copy];
}

/**
 *  Converts a single non bitwise operated HKTContentType to its appropriate request param value
 *
 *  @param contentType  a single non bitwise operated HKTContentType e.g. HKTContentTypeNews
 *
 *  @return An NSString that represents this HKTContentType in API requests
 */
+(NSString*)parameterValueForSingleContentType:(HKTContentType)contentType {
    switch (contentType) {
        case HKTContentTypeMovie:
            return @"movie";
            break;
        case HKTContentTypeSeries:
            return @"series";
            break;
        case HKTContentTypeSeason:
            return @"season";
            break;
        case HKTContentTypeEpisode:
            return @"episode";
            break;
        case HKTContentTypeNews:
            return @"news";
            break;
        case HKTContentTypeTrailer:
            return @"trailer";
            break;
        case HKTContentTypeCollection:
            return @"collection";
            break;
        case HKTContentTypeClip:
            return @"Clips";
            break;
        case HKTContentTypeLive:
            return @"live";
            break;
        default:
            return nil;
    }
}

#pragma mark HKTProductType helpers
/**
 *  Converts an HKTProductType NS_OPTIONS into an array of the appropriate request value strings
 *  e.g. an input of HKTProductTypeAVOD | HKTProductTypeTVOD return @[@"avod", @"tvod"]
 *
 *  @param contentTypeOptions an HKTProductType NS_OPTIONS
 *
 *  @return an array of the appropriate HKTContentType request value strings
 */
+(NSArray<NSString*>*)parameterValuesArrayForProductTypeOptions:(HKTProductType)productTypeOptions
{
    NSMutableArray *paramValueArray = [[NSMutableArray alloc] init];
    for (NSUInteger currentBit=0; currentBit < kBitsUsedByHKTProductTypeOptions; currentBit++) {
        NSUInteger bitValueToCheck = 1 << currentBit;
        if (productTypeOptions & bitValueToCheck) {
            HKTProductType singleProductType = 1 << currentBit;
            [paramValueArray addObject:[self parameterValueForSingleProductType:singleProductType]];
        }
    }
    return [paramValueArray copy];
}

/**
 *  Converts a single non bitwise operated HKTProductType to its appropriate request param value
 *
 *  @param productType  a single non bitwise operated HKTProductType e.g. HKTProductTypeAVOD
 *
 *  @return An NSString that represents this HKTContentType in API requests
 */
+(NSString*)parameterValueForSingleProductType:(HKTProductType)productType {
    switch (productType) {
        case HKTProductTypeAVOD:
            return @"avod";
        case HKTProductTypeTVOD:
            return @"tvod";
        case HKTProductTypeSVOD:
            return @"svod";
        default:
            return nil;
    }
}


+(NSString*)parameterValueForVariant:(HKTVariant)variant
{
    switch (variant) {
        case HKTVariantHD:
            return @"HD";
        case HKTVariantSD:
            return @"SD";
        default:
            return nil;
    }
}

@end
