//
//  PreviousTeam.h
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "JSONObject.h"

@interface API_PreviousTeam : JSONObject

@property (nonatomic, strong) NSString *team;
@property (nonatomic, strong) NSString *tenure;
@property (nonatomic, strong) NSString *teamid;

@end
