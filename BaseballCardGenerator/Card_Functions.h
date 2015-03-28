//
//  Card_Functions.h
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PlayerCard.h"
#import "PaintCodeView.h"

typedef void (^playerCardRetrievedBlock)(PlayerCard *card);

@interface Card_Functions : NSObject

+ (PlayerCard *) getTestPlayerCard;
+ (void) getPlayerWithId: (NSString *) playerId onComplete: (playerCardRetrievedBlock) complete;
+ (PaintCodeView *) teamLogoForTeamId: (NSString *) teamId withFrame: (CGRect) frame;

@end
