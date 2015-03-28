//
//  PaintCodeBarButtonItem.m
//  Squiddle
//
//  Created by Patrick Rills on 10/5/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import "PaintCodeBarButtonItem.h"

@implementation PaintCodeBarButtonItem

- (id) initWithType: (PaintCodeViewType) type target: (id) target action: (SEL) selector
{
    PaintCodeButton *pcb = [PaintCodeButton buttonWithType:type andFrame:CGRectMake(0, 0, 35, 35)];
    [pcb addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    self = [super initWithCustomView:pcb];
    
    return self;
}

@end
