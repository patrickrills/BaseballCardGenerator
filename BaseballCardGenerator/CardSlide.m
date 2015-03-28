//
//  CardSlide.m
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "CardSlide.h"

#define PHOTO_TAG   9999

@implementation CardSlide

- (id) initWithFrame: (CGRect) frame andHistory: (PlayerTeamHistory *) h
{
    if (self = [self initWithFrame:frame])
    {
        self.team = h;
        [self initializeUI];
    }
    
    return self;
}

- (void) initializeUI
{
    self.clipsToBounds = YES;
    
    if (self.team != nil)
    {
        UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        //TODO: Obviously move to BG thread with loader
        photo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.team.photoURL]]];
        photo.contentMode = UIViewContentModeScaleAspectFill;
        photo.tag   = PHOTO_TAG;
        [self addSubview:photo];
        
        UIImageView *teamLogo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
        teamLogo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.team.teamlogoURL]]];
        teamLogo.backgroundColor = [UIColor whiteColor];
        teamLogo.contentMode = UIViewContentModeScaleAspectFit;
        teamLogo.layer.cornerRadius = 50.0;
        teamLogo.layer.borderWidth = 4.0f;
        teamLogo.layer.borderColor = [UIColor whiteColor].CGColor;
        teamLogo.clipsToBounds = YES;
        [self addSubview:teamLogo];
        
        UILabel *year = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 100, 30)];
        year.textAlignment = NSTextAlignmentCenter;
        year.textColor = [UIColor whiteColor];
        year.shadowColor = [UIColor blackColor];
        year.text = self.team.displayYears;
        [self addSubview:year];
    }
}

- (void) layoutSubviews
{
    UIView *p = [self viewWithTag:PHOTO_TAG];
    if (p != nil)
    {
        p.frame = CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height);
    }
}


@end
