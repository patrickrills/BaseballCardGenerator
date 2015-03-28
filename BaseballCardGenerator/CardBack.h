//
//  CardBack.h
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardBack : UIView

@property (nonatomic, strong) NSURL *backURL;

- (id) initWithFrame:(CGRect)frame andURL: (NSString *) url;

- (void) refresh;

@end
