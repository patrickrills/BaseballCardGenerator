//
//  APIRequest.h
//  Food Truck Tracker
//
//  Created by Patrick Rills on 12/15/13.
//  Copyright (c) 2013 Food Truck Tracker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIRequest : NSObject

@property (nonatomic, strong) NSString *urlEndPoint;
@property (nonatomic, strong) NSArray *parameters;
@property Class returnType;
@property (nonatomic, strong) NSDictionary *body;

- (NSURL *) buildURL;

+ (APIRequest *) playerInfoRequestForId: (NSString *) playerId;

@end
