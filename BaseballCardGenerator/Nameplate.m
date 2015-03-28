//
//  Nameplate.m
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "Nameplate.h"

@implementation Nameplate

- (id) initWithFrame:(CGRect)frame andName: (NSString *) name andPosition: (NSString *) position
{
    if (self = [self initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.75];
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, frame.size.width, frame.size.height / 2.0)];
        lbl.text = [NSString stringWithFormat:@"%@", name];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.numberOfLines = 1;
        lbl.font = [UIFont boldSystemFontOfSize:24.0];
        [self addSubview:lbl];
        
        UILabel *lbl2= [[UILabel alloc] initWithFrame:CGRectMake(0, (frame.size.height / 2.0) + 5.0, frame.size.width, 20.0)];
        lbl2.text = [NSString stringWithFormat:@"%@", position];
        lbl2.textAlignment = NSTextAlignmentCenter;
        lbl2.numberOfLines = 1;
        [self addSubview:lbl2];
    }
    return self;
}

@end
