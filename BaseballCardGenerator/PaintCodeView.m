//
//  PaintCodeView.m
//  Squiddle
//
//  Created by Patrick Rills on 9/20/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import "PaintCodeView.h"
#import "BaseballHackDayStyleKit.h"

@implementation PaintCodeView

- (id) initWithType: (PaintCodeViewType) t andFrame: (CGRect) frame
{
    self = [super init];
    if (self)
    {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        self.type = t;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    SEL s = NSSelectorFromString([self selectorForType]);
    IMP imp = [[BaseballHackDayStyleKit class] methodForSelector:s];
    void (*func)(id, SEL, CGRect) = (void *)imp;
    func([BaseballHackDayStyleKit class], s, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
}

- (NSString *) selectorForType
{
    NSString *paintCodeName = @"";
    
    switch (self.type) {
        case CardCorner:
            paintCodeName = @"CardCorner";
            break;
            
        case BostonRedSox:
            paintCodeName = @"BostonRedSox";
            break;
            
        case TexasRangers:
            paintCodeName = @"TexasRangers";
            break;
        
        case TorontoBlueJays:
            paintCodeName = @"TorontoBlueJays";
            break;
        
        case LSU:
            paintCodeName = @"LSU";
            break;
            
        default:
            paintCodeName = @"";
            break;
    }
    
    return [NSString stringWithFormat:@"draw%@WithFrame:", paintCodeName];
}

@end
