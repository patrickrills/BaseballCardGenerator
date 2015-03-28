//
//  JSONObject.h
//  Food Truck Tracker
//
//  Created by Patrick Rills on 12/15/13.
//  Copyright (c) 2013 Food Truck Tracker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONObject : NSObject

- (id) initWithJSON: (NSDictionary *) dict;
- (NSDictionary *) toJSON;
- (NSData *) toJSONData;
- (NSMutableArray *) convertChildArrayToClass: (Class) c withValues: (NSObject *) child;
- (NSData *) convertJSON: (NSDictionary *) dict;

@end
