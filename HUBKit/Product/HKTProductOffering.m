//
//  HKTProductOffering.m
//  HUBKit
//
//  Created by Robert Wagstaff on 9/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTProductOffering.h"
#import "HKTRequestParameter.h"
#define NSLocalizedStringDefault(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"vi" ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]

@implementation HKTProductOffering

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"productType"     :   @"type",
             @"variant"         :   @"variant",
             @"price"           :   @"price",
             @"currency"        :   @"currency",
             @"startDate"       :   @"start_date",
             @"endDate"         :   @"end_date",
             @"payment_type"    :   @"payment_type",
             @"entitled"        :   @"entitled",
             @"timeRemaining"   :   @"time_remaining",
             @"offeringId"        :   @"id"
             };
}

+ (NSValueTransformer*)productTypeJSONTransformer
{
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary
            :@{
               @"AVOD" : @(HKTProductTypeAVOD),
               @"TVOD" : @(HKTProductTypeTVOD),
               @"SVOD" : @(HKTProductTypeSVOD)
               }
            defaultValue:@(HKTProductTypeUnknown) reverseDefaultValue:@""];
}
- (NSString*)convertTimeRemaining{
    NSString *remainingTime = @"";
    NSTimeInterval theTimeInterval = [self.timeRemaining longLongValue];
    
    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
    // Create the NSDates
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:theTimeInterval sinceDate:date1];
    
    // Get conversion to months, days, hours, minutes
    unsigned int unitFlags = NSCalendarUnitHour | NSCalendarUnitDay;
    
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
    if ([conversionInfo day] > 0) {
        remainingTime = [NSString stringWithFormat:@"Còn lại %ld ngày",(long)[conversionInfo day]];
    }else {
        remainingTime = [NSString stringWithFormat:@"Còn lại %ld giờ",(long)[conversionInfo hour]];
    }
    return remainingTime;
}
- (NSString*)navgationBarTitle
{
    NSString *title;
    switch (self.productType) {
        case HKTProductTypeAVOD:
            title = NSLocalizedStringDefault(@"GO",nil);
            break;
        case HKTProductTypeSVOD:
            title = NSLocalizedStringDefault(@"BUFFET",nil);
            break;
        case HKTProductTypeTVOD:
            title = NSLocalizedStringDefault(@"CINEPLEX",nil);
            break;
        default:
            break;
    }
    return title;
}
+ (NSValueTransformer*)variantJSONTransformer
{
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary
            :@{
               
               [HKTRequestParameter parameterValueForVariant:HKTVariantSD] : @(HKTVariantSD),
               [HKTRequestParameter parameterValueForVariant:HKTVariantHD] : @(HKTVariantHD)
               }
            defaultValue:@(HKTVariantUnknown) reverseDefaultValue:@""];
}

+ (NSValueTransformer*)startDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString* dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.offeringDateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate* date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.offeringDateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer*)endDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString* dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.offeringDateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate* date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.offeringDateFormatter stringFromDate:date];
    }];
}


+ (NSDateFormatter*)offeringDateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.locale = [NSLocale currentLocale];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    });
    return dateFormatter;
}



@end
