//
//  Card_Functions.m
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "Card_Functions.h"
#import "PlayerTeamHistory.h"

@implementation Card_Functions

+ (PlayerCard *) getTestPlayerCard
{
    PlayerCard *p = [[PlayerCard alloc] init];
    p.name = @"Anthony Ranaudo";
    p.positionShort = @"RHP";
    p.positionLong = @"Right handed pitcher";
    p.backURL = @"http://www.mlb.com";
    PlayerTeamHistory *h1 = [[PlayerTeamHistory alloc] init];
    h1.photoURLs = [NSArray arrayWithObjects:@"http://img.bleacherreport.net/img/images/photos/003/315/438/hi-res-6c82fbd75fc70d02d83267a13e4e4860_crop_exact.jpg?w=1500&h=1500&q=85", @"http://www.star-telegram.com/sports/mlb/texas-rangers/9990l3/picture16541792/ALTERNATES/FREE_960/ranges.JPG", @"http://assets.sbnation.com/assets/1512365/russell.gif", nil];
    h1.teamlogoURL = @"http://img3.wikia.nocookie.net/__cb20100925023701/logopedia/images/c/ca/Texas_Rangers.png";
    h1.startYear = [NSNumber numberWithInt:2015];
    h1.endYear = nil;
    
    PlayerTeamHistory *h2 = [[PlayerTeamHistory alloc] init];
    h2.photoURLs = [NSArray arrayWithObject:@"http://www.bostonherald.com/sites/default/files/media/2014/09/24/092414sox4.jpg"];
    h2.teamlogoURL = @"http://tsnimages.tsn.ca/ImageProvider/TeamLogo?seoId=boston-red-sox";
    h2.startYear = [NSNumber numberWithInt:2014];
    h2.endYear = [NSNumber numberWithInt:2014];
    
    p.teamHistory = [NSArray arrayWithObjects:h1, h2, nil];
    
    return p;
}

@end