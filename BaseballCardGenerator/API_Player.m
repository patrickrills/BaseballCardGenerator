//
//  API_Player.m
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "API_Player.h"

@implementation API_Player

- (id) initWithJSON: (NSDictionary *) dict
{
    self = [super initWithJSON:dict];
    
    if (self) {
        //self.minutes = [self convertChildArrayToClass:[Minute class] withValues:self.minutes];
    }
    
    return self;
}

@end
