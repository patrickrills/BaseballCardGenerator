//
//  PlayerCard.m
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "PlayerCard.h"
#import "PlayerTeamHistory.h"
#import "Card_Functions.h"

@implementation PlayerCard

- (id) initFromAPI: (API_Player *) apiPlayer
{
    if (self == [self init])
    {
        self.name = apiPlayer.full_name;
        self.positionLong = apiPlayer.primary_position;
        self.headshotURL = apiPlayer.mlb_head_shot;
        
        PlayerTeamHistory *currentTeam = [[PlayerTeamHistory alloc] init];
        currentTeam.photoURLs = [NSArray arrayWithObjects:apiPlayer.mlb_action_shot, apiPlayer.image_url, nil];
        currentTeam.teamName = [NSString stringWithFormat:@"%@ %@", [apiPlayer.team objectForKey:@"market"], [apiPlayer.team objectForKey:@"name"]];
        currentTeam.teamId = [apiPlayer.team objectForKey:@"abbr"];
        currentTeam.tenure = @"2015";
        
        self.teamHistory = [NSArray arrayWithObjects:currentTeam, nil];
    }
    return self;
}

@end
