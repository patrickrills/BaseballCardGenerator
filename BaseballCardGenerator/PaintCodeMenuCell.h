//
//  PaintCodeMenuCell.h
//  Lose-It-Photo-Prototype
//
//  Created by Patrick Rills on 10/22/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenuViewController.h"

@interface PaintCodeMenuCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIView *iconContainer;
@property (nonatomic, weak) IBOutlet UILabel *screenNameLabel;
@property MenuItem menuItem;

- (void) setMenuIconForItem: (MenuItem) mi;

@end
