//
//  API_Player.m
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "API_Player.h"
#import "API_PreviousTeam.h"

@implementation API_Player

- (id) initWithJSON: (NSDictionary *) dict
{
    self = [super initWithJSON:dict];
    
    if (self) {
        self.previous_teams = [self convertChildArrayToClass:[API_PreviousTeam class] withValues:self.previous_teams];
    }
    
    return self;
}

@end
