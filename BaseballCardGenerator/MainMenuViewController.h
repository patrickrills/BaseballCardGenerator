//
//  MainMenuViewController.h
//  Lose-It-Photo-Prototype
//
//  Created by Patrick Rills on 10/19/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UITableViewController

typedef enum {
    ImagesByDay = 0,
    ImagesSummary = 1,
    StoriesList = 2,
    AboutApp = 3,
} MenuItem;

- (void) refreshMenu;

@end
