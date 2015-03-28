//
//  PlayerTeamHistory.m
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "PlayerTeamHistory.h"

@implementation PlayerTeamHistory

- (NSString *) displayYears
{
    if (self.endYear == nil)
        return [NSString stringWithFormat:@"%@-", self.startYear];
    if (self.startYear.integerValue == self.endYear.integerValue)
        return [NSString stringWithFormat:@"%@", self.startYear];
    
    return [NSString stringWithFormat:@"%@-%@", self.startYear, self.endYear];
}

@end
