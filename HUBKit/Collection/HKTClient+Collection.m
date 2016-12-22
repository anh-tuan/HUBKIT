//
//  HKTClient+Collection.m
//  HUBKit
//
//  Created by Robert Wagstaff on 21/09/2015.
//  Copyright © 2015 Movideo. All rights reserved.
//

#import "HKTClient+Collection.h"
#import "HKTCollection.h"
#import "HKTListResponse.h"
#import "RACSignal+HKTClientAdditions.h"

@implementation HKTClient (Collection)


-(RACSignal*) fetchAllCollections
{
    return [self fetchAllCollectionsWithParameters:nil];
}


-(RACSignal*) fetchAllCollectionsWithParameters:(NSArray<HKTRequestParameter*>*)parameters
{
    return [[self fetchAllCollectionsMetadataWithParameters:parameters] flattenMap:^RACStream *(NSArray<HKTCollection*>* collections) {
        
        return [[RACSignal combineLatest:[collections.rac_sequence map:^id(HKTCollection* collection) {
            
            return [self fetchPlaylistWithID:collection.objectID];
        }]]map:^id(RACTuple *tuple) {
            
            return [tuple allObjects];;
        }];
    }];
}

//- (RACSignal*)fetchCollectionWithID:(NSString*)collectionID
- (RACSignal*)fetchPlaylistWithID:(NSString*)playlistID
{
    NSURLRequest *request = [self createRequestForResource:[@"playlist/list/" stringByAppendingString:playlistID]
                                                    method:URLRequestMethodTypeGET
                                                parameters:nil];
    return [self enqueueRequest:request resultClass:HKTCollection.class];
}

- (RACSignal*)fetchAllCollectionsMetadata
{
    return [self fetchAllCollectionsMetadataWithParameters:nil];
}

- (RACSignal*)fetchAllCollectionsMetadataWithParameters:(NSArray<HKTRequestParameter*>*)parameters
{
    NSURLRequest *request = [self createRequestForResource:@"playlist"
                                                    method:URLRequestMethodTypeGET
                                                parameters:[HKTRequestParameter dictionaryForRequestParameters:parameters]];
    
    return [[self enqueueRequest:request resultClass:HKTListResponse.class] hkt_parsedCollectionsList];
}




@end
