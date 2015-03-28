//
//  API_Player.h
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObject.h"

@interface API_Player : JSONObject

@property (nonatomic, strong) NSString *primary_position;
@property (nonatomic, strong) NSString *full_name;
@property (nonatomic, strong) NSString *mlb_head_shot;
@property (nonatomic, strong) NSString *mlb_action_shot;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, strong) NSDictionary *team;

@end
