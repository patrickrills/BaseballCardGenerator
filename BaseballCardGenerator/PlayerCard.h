//
//  PlayerCard.h
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerCard : NSObject

@property (nonatomic, strong) NSString *headshotURL;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *backURL;
@property (nonatomic, strong) NSString *positionShort;
@property (nonatomic, strong) NSString *positionLong;

@property (nonatomic, strong) NSArray *teamHistory;

@end
