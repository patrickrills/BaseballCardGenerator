//
//  PaintCodeButton.m
//  Squiddle
//
//  Created by Patrick Rills on 10/5/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import "PaintCodeButton.h"

@implementation PaintCodeButton

+ (PaintCodeButton *) buttonWithType: (PaintCodeViewType) type andFrame: (CGRect) frame
{
    PaintCodeButton *b = [PaintCodeButton buttonWithType:UIButtonTypeCustom];
    b.frame = frame;
    
    UIView *pc = [[PaintCodeView alloc] initWithType:type andFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [pc setUserInteractionEnabled:NO];
    
    [b addSubview:pc];
    
    return b;
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted)
    {
        self.alpha = 0.2;
    }
    else
    {
        self.alpha = 1.0;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setHighlighted:NO];
}

@end
