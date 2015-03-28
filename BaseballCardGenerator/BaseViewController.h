//
//  BaseViewController.h
//  Stickies
//
//  Created by Patrick Rills on 6/12/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

typedef enum {
    PlayerListScreen,
    PlayerCardScreen,
    Unknown,
} ScreenType;

- (void) toggleLeftMenuManual;
- (IBAction)toggleLeftMenu:(id)sender;
- (ScreenType) screenType;
- (void) refreshScreen;
- (void) showLoading;
- (void) hideLoading;
- (void) addBarButtons;
- (void) addMenuBarButtonItem;
- (NSString *) screenTitle;
- (BOOL) requiresRefreshForUserInformation;
- (void) initializeUI;
- (void) displayAlertOnMainThread: (NSString *) alertMsg isError: (BOOL) err;
- (void) adjustViewForNavigationBarVisible: (BOOL) isVisible;
- (void) registerCellsForTableView: (UITableView *) tableView;

//- (void) launchLookupPickerOfType: (Class<Lookup>) t;
//- (void) lookupValueSelected: (NSObject *) val forLookupType: (Class) t;

@end
