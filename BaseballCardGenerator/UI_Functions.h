//
//  UI_Functions.h
//  Stickies
//
//  Created by Patrick Rills on 6/12/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "BaseViewController.h"

@interface UI_Functions : NSObject

+ (void) adjustTableViewForStatusBar: (UITableView *) tbl;
+ (void) changeNavigationBar: (UINavigationController *) n toTintColor: (UIColor *) color;
+ (void) tableView: (UITableView *) tbl setBackGroundToImageNamed: (NSString *) fileName;
+ (BOOL) isiOS7OrHigher;
+ (BOOL) isPhone;
+ (BOOL) isShortPhone;
+ (void) initializeUserInterface: (AppDelegate *) del;
+ (void) toggleLeftMenu;
+ (void) refreshUI: (BOOL) includeMenu forAuth: (BOOL) forAuth;
+ (void) showLoading;
+ (void) hideLoading;
+ (void) openModal: (UIViewController *) subView completion: (void (^)()) onComplete;
+ (void) browseToScreen: (ScreenType) screen;
+ (void) browseBackward;
+ (void) toggleNavigationBarVisibility: (BOOL) show;
//+ (void) handleLaunchFromNotification: (UILocalNotification *) n;
+ (void) toggleStatusBar: (BOOL) off;


@end
