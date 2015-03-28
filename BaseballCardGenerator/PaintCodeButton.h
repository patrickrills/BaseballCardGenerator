//
//  PaintCodeButton.h
//  Squiddle
//
//  Created by Patrick Rills on 10/5/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaintCodeView.h"

@interface PaintCodeButton : UIButton

+ (PaintCodeButton *) buttonWithType: (PaintCodeViewType) type andFrame: (CGRect) frame;

@end
