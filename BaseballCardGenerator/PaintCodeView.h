//
//  PaintCodeView.h
//  Squiddle
//
//  Created by Patrick Rills on 9/20/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CardCorner,
    TexasRangers,
    BostonRedSox,
    TorontoBlueJays,
} PaintCodeViewType;

@interface PaintCodeView : UIView

@property (nonatomic) PaintCodeViewType type;

- (id) initWithType: (PaintCodeViewType) t andFrame: (CGRect) frame;

@end