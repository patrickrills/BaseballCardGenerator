//
//  PaintCodeBarButtonItem.h
//  Squiddle
//
//  Created by Patrick Rills on 10/5/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaintCodeButton.h"

@interface PaintCodeBarButtonItem : UIBarButtonItem

- (id) initWithType: (PaintCodeViewType) type target: (id) target action: (SEL) selector;

@end
