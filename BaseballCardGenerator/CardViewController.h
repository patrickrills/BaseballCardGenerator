//
//  CardViewController.h
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "BaseViewController.h"
#import "PlayerCard.h"
#import "CardFront.h"
#import "Nameplate.h"
#import "CardBack.h"

@interface CardViewController : BaseViewController

@property (nonatomic, strong) PlayerCard *currentCard;
@property (nonatomic, strong) CardFront *front;
@property (nonatomic, strong) CardBack *back;
@property (nonatomic, assign) Nameplate *name;
@property (nonatomic, assign) UIImageView *head;

@end
