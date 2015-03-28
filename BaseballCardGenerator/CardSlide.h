//
//  CardSlide.h
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerTeamHistory.h"

@interface CardSlide : UIView

@property (nonatomic, assign) PlayerTeamHistory *team;

- (id) initWithFrame: (CGRect) frame andHistory: (PlayerTeamHistory *) h;

@end
