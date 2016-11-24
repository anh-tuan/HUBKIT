//
//  HKTObject.h
//  HUBKit
//
//  Created by Robert Wagstaff on 8/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import <Mantle/Mantle.h>

//all objects will have a type
typedef NS_ENUM(NSUInteger, HKTObjectType) {
    HKTObjectTypeUnknown,          //Unknown type
    HKTObjectTypeProduct,          //Product such as a movie, series, trailer, clips etc
    HKTObjectTypeUser,             //A user
    HKTObjectTypeList,             //A list of objects e.g. a list of products that match a search result
    HKTObjectTypeCollection,       //A custom predifined collection e.g. Popular Shows
    HKTObjectTypeDevice,           //A device used to access the content. e.g. 'John Smiths iPhone'
    HKTObjectTypeRail              //A Rail for Home screen
};

@interface HKTObject : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *objectID;
@property (nonatomic, readonly) HKTObjectType objectType;

@end
