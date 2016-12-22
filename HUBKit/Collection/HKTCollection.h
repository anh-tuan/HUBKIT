//
//  HKTCollection.h
//  HUBKit
//
//  Created by Robert Wagstaff on 10/09/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "HKTObject.h"
@class HKTProduct;
@class HKTImageMetaData;

//Represents a collection of products such as a rail on the home page
@interface HKTCollection : HKTObject

//@property (nonatomic, copy, readonly) NSString *title;
//@property (nonatomic, copy, readonly) NSString *collectionDescription;
@property (nonatomic, copy, readonly) NSString *playlist_name;
@property (nonatomic, readonly) NSInteger playlist_id;


//@property (nonatomic, copy, readonly) HKTImageMetaData* defaultImage;
//@property (nonatomic, copy, readonly) HKTImageMetaData* posterImage;
//@property (nonatomic, copy, readonly) HKTImageMetaData* backgroundImage;

@property (nonatomic, copy, readonly) NSArray<HKTProduct*>* products;

@end
