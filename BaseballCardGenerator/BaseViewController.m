//
//  BaseViewController.m
//  Stickies
//
//  Created by Patrick Rills on 6/12/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import "BaseViewController.h"
#import "UI_Functions.h"
#import "AppDelegate.h"
#import "PaintCodeBarButtonItem.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initializeUI];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void) initializeUI
{
    self.title = [self screenTitle];
    [self addBarButtons];
}

- (void) toggleLeftMenuManual
{
    [UI_Functions toggleLeftMenu];
}

- (IBAction)toggleLeftMenu:(id)sender
{
    [self toggleLeftMenuManual];
}

- (NSString *) screenTitle
{
    switch ([self screenType]) {
            
        case PlayerListScreen:
            return @"Players";
            
        default:
            return nil;

    }
    
    return nil;
}

- (void) addBarButtons
{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void) addMenuBarButtonItem
{
    //UIBarButtonItem *menu = [[PaintCodeBarButtonItem alloc] initWithType:LoseItScale target:self action:@selector(toggleLeftMenu:)];
    //self.navigationItem.leftBarButtonItem = menu;
}

- (ScreenType) screenType
{
    //Must override
    return Unknown;
}

- (void) refreshScreen
{
    //must override
}

- (void) showLoading
{
    [UI_Functions showLoading];
}

- (void) hideLoading
{
    [UI_Functions hideLoading];
}

- (BOOL) requiresRefreshForUserInformation
{
    return NO;
}

- (void) displayAlertOnMainThread: (NSString *) alertMsg isError: (BOOL) err
{
    NSString *t = @"Squiddle";
    if (err) {
        t = @"Error";
    }
    
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:t message:alertMsg delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    [self performSelectorOnMainThread:@selector(showMsg:) withObject:a waitUntilDone:NO];
}

- (void) showMsg: (UIAlertView *) a
{
    [a show];
}

- (void) adjustViewForNavigationBarVisible: (BOOL) isVisible
{
    //must override
}

- (void) registerCellsForTableView: (UITableView *) tableView
{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [tableView registerNib:[UINib nibWithNibName:@"MealPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"MealPhotoCell"];
}


@end
