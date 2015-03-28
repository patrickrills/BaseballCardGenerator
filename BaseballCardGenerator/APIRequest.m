//
//  APIRequest.m
//
//  Created by Patrick Rills on 12/15/13.
//  Copyright (c) 2013 Food Truck Tracker. All rights reserved.
//

#import "APIRequest.h"
#import "Utility_Functions.h"
#import "UI_Functions.h"

#import "API_Player.h"

@implementation APIRequest

- (NSURL *) buildURL {
    
    NSMutableString *address = [[NSMutableString alloc]
								initWithString: [NSString stringWithFormat:@"http://baseball-card.herokuapp.com/%@",
												 self.urlEndPoint]];
    
    for (NSString *str in self.parameters) {
        [address appendFormat:@"/%@", [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
                                                 
    NSLog(@"%@", address);
    NSURL *url = [NSURL URLWithString:address];
    return url;
}

+ (APIRequest *) playerInfoRequestForId: (NSString *) playerId
{
    APIRequest *p = [[APIRequest alloc] init];
    p.returnType = [API_Player class];
    p.urlEndPoint = @"players";
    p.parameters = [NSArray arrayWithObject:playerId];
    return p;
}

@end
