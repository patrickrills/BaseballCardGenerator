//
//  CardBack.m
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "CardBack.h"

#define WEB_TAG 8888

@implementation CardBack

- (id) initWithFrame:(CGRect)frame andURL: (NSString *) url
{
    if (self = [self initWithFrame:frame])
    {
        self.backURL = [NSURL URLWithString:url];
        
        UIWebView *w = [[UIWebView alloc] initWithFrame:frame];
        w.tag = WEB_TAG;
        [self addSubview:w];
    }
    return self;
}

- (void) refresh
{
    if (self.backURL != nil)
    {
        UIWebView *w = (UIWebView *)[self viewWithTag:WEB_TAG];
        if (w.request == nil)
        {
            [w loadRequest:[NSURLRequest requestWithURL:self.backURL]];
        }
        else
        {
            [w reload];
        }
    }
    
}

@end
