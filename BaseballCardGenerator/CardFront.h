//
//  CardFront.h
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardFront : UIView

@property (nonatomic, assign) UIScrollView *historyScroll;
@property (nonatomic, assign) NSArray *teamHistory;

- (id) initWithFrame:(CGRect)frame andHistory: (NSArray *) teams;

@end
