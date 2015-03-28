//
//  PlayerTeamHistory.h
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerTeamHistory : NSObject

@property (nonatomic, strong) NSString *photoURL;
@property (nonatomic, strong) NSString *teamName;
@property (nonatomic, strong) NSString *teamlogoURL;
@property NSNumber *startYear;
@property NSNumber *endYear;

- (NSString *) displayYears;

@end
