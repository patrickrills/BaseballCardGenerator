//
//  CardFront.m
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "CardFront.h"
#import "PlayerTeamHistory.h"
#import "CardSlide.h"

@implementation CardFront

- (id) initWithFrame:(CGRect)frame andHistory: (NSArray *) teams
{
    if (self = [self initWithFrame:frame])
    {
        self.teamHistory = teams;
        [self initializeUI];
    }
    return self;
}

- (void) initializeUI
{
    if (self.historyScroll == nil)
    {
        NSLog(@"%f x %f", self.frame.size.width, self.frame.size.height);
        
        UIScrollView *s = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:s];
        self.historyScroll = s;
        self.historyScroll.pagingEnabled = YES;
        self.historyScroll.showsHorizontalScrollIndicator = NO;
        self.historyScroll.showsVerticalScrollIndicator = NO;
        
        if (self.teamHistory != nil)
        {
            for (NSInteger h = (self.teamHistory.count - 1); h >= 0; h--)
            {
                NSInteger idx = (self.teamHistory.count - 1) - h;
                
                PlayerTeamHistory *t = (PlayerTeamHistory *)[self.teamHistory objectAtIndex:h];
                CardSlide *s = [[CardSlide alloc] initWithFrame:CGRectMake(idx * self.historyScroll.frame.size.width, 0, self.historyScroll.frame.size.width, self.historyScroll.frame.size.height) andHistory:t];
                
                [self.historyScroll addSubview:s];
                
            }
            
            //start at latest team
            self.historyScroll.contentOffset = CGPointMake(((self.teamHistory.count - 1) * self.historyScroll.frame.size.width), 0);
        }
    }
}

- (void) layoutSubviews
{
    if (self.historyScroll != nil && self.teamHistory)
    {
        self.historyScroll.contentSize = CGSizeMake(self.frame.size.width * self.teamHistory.count, self.frame.size.height);
    }
}

@end
