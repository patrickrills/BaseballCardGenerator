//
//  PaintCodeMenuCell.m
//  Lose-It-Photo-Prototype
//
//  Created by Patrick Rills on 10/22/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import "PaintCodeMenuCell.h"
#import "PaintCodeView.h"

@implementation PaintCodeMenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setMenuIconForItem: (MenuItem) mi
{
    self.menuItem = mi;
    
    if (self.iconContainer.subviews.count > 0)
    {
        [(UIView *)[self.iconContainer.subviews objectAtIndex:0] removeFromSuperview];
    }
    
    PaintCodeViewType pcvt;
    NSString *screenName = @"";
    
    switch (mi) {
        case ImagesByDay:
            pcvt = DailyIcon;
            screenName = @"Today";
            break;
            
        case ImagesSummary:
            pcvt = SummaryIcon;
            screenName = @"Summary";
            break;
        
        case StoriesList:
            pcvt = StoriesIcon;
            screenName = @"Stories";
            break;
            
        case AboutApp:
            pcvt = LoseItScale;
            screenName = @"About";
            break;
            
        default:
            break;
    }
    
    PaintCodeView *pcv = [[PaintCodeView alloc] initWithType:pcvt andFrame:CGRectMake(2, 2, 50, 50)];
    [self.iconContainer addSubview:pcv];
    self.screenNameLabel.text = screenName;
}

@end
