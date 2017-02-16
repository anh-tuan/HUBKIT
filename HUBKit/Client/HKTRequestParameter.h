//
//  HKTRequestParam.h
//  HUBKit
//
//  Created by Robert Wagstaff on 10/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  The following request parameters are supported in all product and collection related calls.
 For example specifying "genres" to be ["action", "romance"] will result in only those genres being returned from a call to /products, /collections or even /products/{product_id}/related
 */
typedef NS_ENUM(NSUInteger, HKTRequestParameterType){
    /**  Unknown parameter */
    HKTRequestParameterTypeUnknown,
    /** Pagination parameter - The page to be returned */
    HKTRequestParameterTypePage,
    /** Pagination parameter - The number of results to return. Maximum value of 250 */
    HKTRequestParameterTypeLimit,
    /** Content Type - See HKTContentType */
    HKTRequestParameterTypeContentTypes,
    HKTRequestParameterTypeTypes,
    /** Product Type - See HKTProductType */
    HKTRequestParameterTypeProductTypes,
    /** Content types to be excluded from the results - See HKTContentType */
    HKTRequestParameterTypeExcludeContentTypes,
    /** Content genre identified at the time of curation */
    HKTRequestParameterTypeGenres,
    /** Countries the product(s) originate from */
    HKTRequestParameterTypeOriginCountries,
    /** Content should have been published in or after this year */
    HKTRequestParameterTypeMinYear,
    /** Content should have been published in or before this year */
    HKTRequestParameterTypeMaxYear,
    /** Freeform parameter for people search (actors, writers, directors etc). This would only apply for a top level item such as TV Series or a Movie. */
    HKTRequestParameterTypePeople,
    /** Freeform field for classification rating search */
    HKTRequestParameterTypeRatings,
    /** Audio Languages */
    HKTRequestParameterTypeAudios,
    /** Subtitle Languages */
    HKTRequestParameterTypeSubtitles
};

/** The type of content e.g. movie or trailer */
typedef NS_OPTIONS(NSUInteger, HKTContentType) {
    /** Unknown type */
    HKTContentTypeUnknown       = 0,
    /** Feature films */
    HKTContentTypeMovie         = 1 << 0,
    /** TV series */
    HKTContentTypeSeries        = 1 << 1,
    /** Seasons under a TV series */
    HKTContentTypeSeason        = 1 << 2,
    /** Episodes under a season */
    HKTContentTypeEpisode       = 1 << 3,
    /** News videos, typically short-form */
    HKTContentTypeNews          = 1 << 4,
    /** Trailers */
    HKTContentTypeTrailer       = 1 << 5,
    /** Collection of other products or bundle offers */
    HKTContentTypeCollection    = 1 << 6,
    /** User generated video clips or non-standard content, typically short form */
    HKTContentTypeClip          = 1 << 7,
    /** Live streams*/
    HKTContentTypeLive          = 1 << 8,
};
#define kBitsUsedByHKTContentTypeOptions 9

/** AVOD, TVOD or SVOD */
typedef NS_OPTIONS(NSUInteger, HKTProductType) {
    /** Unknown */
    HKTProductTypeUnknown       = 0,
    /** AVOD - Free */
    HKTProductTypeAVOD          = 1 << 0,
    /** TVOD - Transactional */
    HKTProductTypeTVOD          = 1 << 1,
    /** SVOD - Subscription */
    HKTProductTypeSVOD          = 1 << 2
};
#define kBitsUsedByHKTProductTypeOptions 3

typedef NS_ENUM(NSUInteger, HKTVariant) {
    /** Unknown */
    HKTVariantUnknown,
    /** SD */
    HKTVariantSD,
    /** HD */
    HKTVariantHD
};


/**
 *  Class used to represent the valid request parameters for the HUB API and associated enumerations and transformations
 */
@interface HKTRequestParameter : NSObject

/**
 *  The Type of the HTTP request parameter. Maps to the correct request key
 */
@property(nonatomic, readonly) HKTRequestParameterType requestParameterType;
/**
 *  The value of the the HTTP request parameter
 */
@property(nonatomic, readonly, copy) id requestParameterValue;

/**
 *  Creates a HKTRequestParameter with type HKTRequestParameterTypePage
 *
 *  @param page an NSNumber for the page number e.g. 1
 *
 *  @return A new HKTRequestParameter object or nil if the parameters were invalid
 */
+(HKTRequestParameter*) parameterWithPage:(NSNumber*)page;

/**
 *  Creates a HKTRequestParameter with type HKTRequestParameterTypeLimit
 *
 *  @param limit an NSNumber for the number of results e.g. 20
 *
 *  @return A new HKTRequestParameter object or nil if the parameters were invalid
 */
+(HKTRequestParameter*) parameterWithLimit:(NSNumber*)limit;

/**
 *  Creates a HKTRequestParameter with type HKTRequestParameterTypeContentTypes
 *
 *  @param contentTypes an NS_OPTIONS of the required contentTypes e.g. HKTContentMovie | HKTContentTrailer
 *
 *  @return A new HKTRequestParameter object or nil if the parameters were invalid
 */
+(HKTRequestParameter*) parameterWithContentTypeOptions:(HKTContentType)contentTypeOptions;

/**
 *  Creates a HKTRequestParameter with type HKTRequestParameterTypeProductOfferings
 *
 *  @param productOfferings NS_OPTIONS of the required contentTypes e.g. HKTProductTypeAVOD | HKTProductTypeTVOD
 *
 *  @return A new HKTRequestParameter object or nil if the parameters were invalid
 */
+(HKTRequestParameter*) parameterWithProductTypeOptions:(HKTProductType)productTypeOptions;

/**
 *  Creates a HKTRequestParameter with type HKTRequestParameterTypeExcludeContentTypes
 *
 *  @param excludedContentTypes an NS_OPTIONS of the excluded contentTypes e.g. HKTContentMovie | HKTContentTrailer
 *
 *  @return A new HKTRequestParameter object or nil if the parameters were invalid
 */
+(HKTRequestParameter*) parameterWithExcludedContentTypeOptions:(HKTContentType)contentTypeOptions;

/**
 *  Creates a HKTRequestParameter with type HKTRequestParameterTypeGenres
 *
 *  @param genres an NSArray of NSString e.g. @[@"action"]
 *
 *  @return A new HKTRequestParameter object or nil if the parameters were invalid
 */
+(HKTRequestParameter*) parameterWithGenres:(NSArray<NSString*>*)genres;

/**
 *  Creates a HKTRequestParameter with type HKTRequestParameterTypeOriginCountries
 *
 *  @param originCountries an NSArray of NSString e.g. @[@"en", @"fr"]
 *
 *  @return A new HKTRequestParameter object or nil if the parameters were invalid
 */
+(HKTRequestParameter*) parameterWithOriginCountries:(NSArray<NSString*>*)originCountries;

/**
 *  Creates a HKTRequestParameter with type HKTRequestParameterTypeMinYear
 *
 *  @param minYear an NSNumber for the year e.g. "2006"
 *
 *  @return A new HKTRequestParameter object or nil if the parameters were invalid
 */
+(HKTRequestParameter*) parameterWithMinYear:(NSNumber*)minYear;

/**
 *  Creates a HKTRequestParameter with type HKTRequestParameterTypeMaxYear
 *
 *  @param maxYear an NSNumber for the year e.g. "2014"
 *
 *  @return A new HKTRequestParameter object or nil if the parameters were invalid
 */
+(HKTRequestParameter*) parameterWithMaxYear:(NSNumber*)maxYear;

/**
 *  Creates a HKTRequestParameter with type HKTRequestParameterTypePeople
 *
 *  @param people an NSArray of NSString e.g. @[@"George Clooney"]
 *
 *  @return A new HKTRequestParameter object or nil if the parameters were invalid
 */
+(HKTRequestParameter*) parameterWithPeople:(NSArray<NSString*>*)people;

/**
 *  Creates a HKTRequestParameter with type HKTRequestParameterTypeRatings
 *
 *  @param ratings an NSArray of NSString e.g. @[@"MA15+, MA"]
 *
 *  @return A new HKTRequestParameter object or nil if the parameters were invalid
 */
+(HKTRequestParameter*) parameterWithRatings:(NSArray<NSString*>*)ratings;

/**
 *  Creates a HKTRequestParameter with type HKTRequestParameterTypeAudios
 *
 *  @param audios an NSArray of NSString  e.g. @[@"en", @"fr"]
 *
 *  @return A new HKTRequestParameter object or nil if the parameters were invalid
 */
+(HKTRequestParameter*) parameterWithAudios:(NSArray<NSString*>*)audios;

/**
 *  Creates a HKTRequestParameter with type HKTRequestParameterTypeSubtitles
 *
 *  @param subtitles an NSArray of NSString  e.g. @[@"ar", @"zh"]
 *
 *  @return A new HKTRequestParameter object or nil if the parameters were invalid
 */
+(HKTRequestParameter*) parameterWithSubtitles:(NSArray<NSString*>*)subtitles;

/**
 *  Helper method to convert an array of HKTRequestParameters into an NSDictionary so that it can be converted into request parameters via AFNetworking
 *
 *  @param requestParameters An NSArray of valid HKTRequestParameter objects
 *
 *  @return AN NSDictionary representing all the HKTRequestParameters supplied
 */
+(NSDictionary*) dictionaryForRequestParameters:(NSArray<HKTRequestParameter*>*)requestParameters;

/**
 *  Returns the parameter string value for a HKTVariant
 *
 *  @param variant a HKTVariant eg HKTVariantHD
 *
 *  @return the api parameter value e.g. "hd"
 */
+(NSString*)parameterValueForVariant:(HKTVariant)variant;

/**
 *  Returns the parameter string value for a HKTProductType
 *
 *  @param productType a HKTProductType e.g. HKTProductTypeTVOD
 *
 *  @return the api parameter value e.g. "tvod"
 */
+(NSString*)parameterValueForSingleProductType:(HKTProductType)productType;

/**
 *  Returns the parameter string value for a HKTContentType
 *
 *  @param contentType a HKTContentType e.g. HKTContentTypeSeries
 *
 *  @return the api parameter value e.g. "series"
 */
+(NSString*)parameterValueForSingleContentType:(HKTContentType)contentType;

@end
