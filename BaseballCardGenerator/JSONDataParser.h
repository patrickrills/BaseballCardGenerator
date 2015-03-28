//
//  JSONDataParser.h
//  Food Truck Tracker
//
//  Created by Patrick Rills on 12/15/13.
//  Copyright (c) 2013 Food Truck Tracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIRequest.h"

typedef void (^completionBlock)(BOOL isError, NSMutableArray *objsRetrieved);

@interface JSONDataParser : NSObject

@property (nonatomic, strong) NSMutableData *responseData;
@property Class returnType;
@property (nonatomic, copy) completionBlock completeBlock;
@property int responseCode;

- (void) getObjects: (APIRequest *) apiRequest completion: (completionBlock) onCompletion;
- (void) postObjects: (NSData *) JSONobjs toURL: (APIRequest *) apiRequest  completion: (completionBlock) onCompletion;

@end
