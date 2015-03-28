//
//  CardSlide.m
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "CardSlide.h"
#import "UIImage+animatedGIF.h"

#define SCROLL_TAG   9999

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
        UIScrollView *s = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        s.pagingEnabled = YES;
        s.showsVerticalScrollIndicator = YES;
        s.showsHorizontalScrollIndicator = NO;
        s.tag = SCROLL_TAG;
        s.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * self.team.photoURLs.count);
        [self addSubview:s];
        
        for (NSInteger x = 0; x < self.team.photoURLs.count; x++)
        {
            UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height * x, self.frame.size.width, self.frame.size.height)];
            NSString *u = (NSString *)[self.team.photoURLs objectAtIndex:x];
            //TODO: Obviously move to BG thread with loader
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:u]];
            
            if ([[u lowercaseString] hasSuffix:@".gif"])
            {
                photo.image = [UIImage animatedImageWithAnimatedGIFData:imageData];
            }
            else
            {
                photo.image = [UIImage imageWithData:imageData];
            }
            
            photo.contentMode = UIViewContentModeScaleAspectFill;
            [s addSubview:photo];
        }
        
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
    UIView *p = [self viewWithTag:SCROLL_TAG];
    p.frame = CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height);
    for (UIView *s in p.subviews)
    {
        if ([s isKindOfClass:[UIImageView class]])
        {
            s.frame = CGRectMake(0, s.frame.origin.y, self.superview.frame.size.width, self.superview.frame.size.height);
        }
    }}


@end
