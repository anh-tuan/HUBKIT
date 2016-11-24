//
//  HKTMetaData.h
//  HUBKit
//
//  Created by Infosys on 23/11/15.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import <Mantle/Mantle.h>

//all metadata will have a type
typedef NS_ENUM(NSUInteger, HKTMetaDataType) {
    HKTMetaDataTypeUnknown,         //Unknown type
    HKTMetaDataTypeGenre,           //Genres such as Action, Thriller, Comedy, Adventure etc
    HKTMetaDataTypeCountry          //Countries such as Australia, USA etc
};

@interface HKTMetaData : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSString *name;

@end
