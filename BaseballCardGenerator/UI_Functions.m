//
//  UI_Functions.m
//  Stickies
//
//  Created by Patrick Rills on 6/12/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import "UI_Functions.h"
#import "Utility_Functions.h"
#import "MainMenuViewController.h"
#import "IIViewDeckController.h"
#import "ModalNavigationController.h"
#import "CardViewController.h"
#import "PlayerListViewController.h"

@implementation UI_Functions

+ (void) adjustTableViewForStatusBar: (UITableView *) tbl
{
    if ([UI_Functions isiOS7OrHigher]) {
        [tbl setContentInset:UIEdgeInsetsMake(20, tbl.contentInset.left, tbl.contentInset.bottom, tbl.contentInset.right)];
    }
}

+ (void) changeNavigationBar: (UINavigationController *) n toTintColor: (UIColor *) color
{
    //iOS 7 - set bar color
    if ([n.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        //n.navigationBar.barTintColor = color;
        //n.navigationBar.barTintColor = [UIColor whiteColor];
        n.navigationBar.barStyle = UIBarStyleDefault;
        n.navigationBar.translucent = YES;
        //n.navigationBar.tintColor = [UIColor whiteColor];
        n.navigationBar.tintColor = color;
    } else {
        n.navigationBar.tintColor = color;
    }
}

+ (void) tableView: (UITableView *) tbl setBackGroundToImageNamed: (NSString *) fileName
{
	tbl.backgroundView = nil;
    tbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:fileName]];
}

+ (BOOL) isiOS7OrHigher
{
    NSString *ver = [[UIDevice currentDevice] systemVersion];
    float version = [ver floatValue];
    
    if (version >= 7.0f) {
        return YES;
    }
    
    return NO;
}

+ (BOOL) isPhone
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
	{
		return YES;
    }
	
	return NO;
}

+ (BOOL) isShortPhone
{
    if ([UI_Functions isPhone]) {
        
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            return (result.height <= 480.0);
        }
        
        return YES;
    }
    
    return NO;
}

+ (void) initializeUserInterface: (AppDelegate *) del
{
    PlayerListViewController *h = [[PlayerListViewController alloc] init];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:h];
    //[UI_Functions changeNavigationBar:n toTintColor:[Utility_Functions getPrimaryColor]];
    n.navigationBar.tintColor = [Utility_Functions getPrimaryColor];
    
    //Disable swipe back gesture
    n.interactivePopGestureRecognizer.enabled = NO;
    
    MainMenuViewController *m = [[MainMenuViewController alloc] init];
    IIViewDeckController *d = [[IIViewDeckController alloc] initWithCenterViewController:n leftViewController:m rightViewController:nil];
    
    //Disable opening of menu with swipe gestures so you can draw
    d.enabled = NO;
    d.panningCancelsTouchesInView = NO;
    d.panningMode = IIViewDeckNoPanning;
    
    if ([UI_Functions isPhone]) {
        d.leftSize = 150;
    } else {
        d.leftSize = 400;
    }
    
    d.automaticallyUpdateTabBarItems = YES;
    d.navigationControllerBehavior = IIViewDeckNavigationControllerIntegrated;
    del.deck = d;
    del.window.rootViewController = d;
}

+ (void) toggleLeftMenu
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (del.deck != nil)
    {
        if (del.deck.isAnySideOpen) {
            [del.deck closeLeftViewAnimated:YES];
        } else {
            [del.deck openLeftViewAnimated:YES];
        }
    }
}

/*
+ (void) showLogin
{
    if ([Auth_Functions userToken] == nil)
    {
        LoginViewController *l = [[LoginViewController alloc] init];
        [UI_Functions openModal:l];
    }
}
*/

+ (void) refreshUI: (BOOL) includeMenu forAuth: (BOOL) forAuth
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (del.deck != nil)
    {
        if (del.deck.centerController != nil)
        {
            if (del.deck.leftController != nil && includeMenu)
            {
                MainMenuViewController *m = (MainMenuViewController *)del.deck.leftController;
                [m refreshMenu];
            }
            
            UINavigationController *nav = (UINavigationController *)del.deck.centerController;
            //[UI_Functions showLoading];
            for (UIViewController *v in nav.viewControllers) {
                if ([v isKindOfClass:[BaseViewController class]]) {
                    BaseViewController *bvc = (BaseViewController *)v;
                    if (!forAuth || (forAuth && [bvc requiresRefreshForUserInformation])) {
                        [NSThread detachNewThreadSelector:@selector(refreshScreen) toTarget:bvc withObject:nil];
                    }
                }
            }
        }
    }
}

+(void) showLoading
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[UI_Functions createLoading];
	[del.window addSubview:del.loadingPanel];
}

+ (void) hideLoading
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	if (del.loadingPanel != nil) {
		[del.loadingPanel removeFromSuperview];
	}
}

+ (void) createLoading
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
	UIView *lp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
	lp.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
	lp.frame = CGRectMake(0, 0, 150, 150);
    lp.layer.cornerRadius = 6.0;
	
	UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[loading setCenter:CGPointMake(75, 75)];
	[lp addSubview:loading];
	[loading startAnimating];
	
	lp.center = CGPointMake(del.window.bounds.size.width/2.0, del.window.bounds.size.height/2.0);
	del.loadingPanel = lp;
}

+ (void) openModal: (UIViewController *) subView completion: (void (^)()) onComplete
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (del.deck != nil)
    {
        if (del.deck.centerController != nil)
        {
            UINavigationController *nav = (UINavigationController *)del.deck.centerController;
            
            UIModalPresentationStyle s = UIModalPresentationFullScreen;
            if (![UI_Functions isPhone]) {
                s = UIModalPresentationFormSheet;
            }
            
            ModalNavigationController *mNav = [[ModalNavigationController alloc] initWithRootViewController:subView];
            //mNav.navigationBar.tintColor = [Utility_Functions getPrimaryColor];
            //[UI_Functions changeNavigationBar:mNav toTintColor:[Utility_Functions getPrimaryColor]];
            
            //iOS 7 - set bar color
            if ([mNav.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
                mNav.navigationBar.barTintColor = [Utility_Functions getPrimaryColor];
                mNav.navigationBar.barStyle = UIBarStyleBlack;
                mNav.navigationBar.translucent = NO;
                mNav.navigationBar.tintColor = [UIColor whiteColor];
            } else {
                mNav.navigationBar.tintColor = [Utility_Functions getPrimaryColor];
            }
            
            mNav.modalPresentationStyle = s;
            [nav presentViewController:mNav animated:YES completion:onComplete];
        }
    }
}

+ (void) browseToScreen: (ScreenType) screen
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (del.deck != nil)
    {
        if (del.deck.centerController != nil)
        {
            UIViewController *x = nil;
            
            UINavigationController *nav = (UINavigationController *)del.deck.centerController;
            if (nav.topViewController != nil)
            {
                BaseViewController *vc = (BaseViewController *)nav.topViewController;
                if ([vc screenType] != screen) {
                    switch (screen) {
                        
                            
                        default:
                            break;
                    }
                }
            }
            
            if (x != nil) {
                [nav setViewControllers:[NSArray arrayWithObject:x] animated:YES];
            }
        }
        
    }
    
    [UI_Functions toggleLeftMenu];
}

+ (void) browseBackward
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (del.deck != nil)
    {
        if (del.deck.centerController != nil)
        {
            UINavigationController *nav = (UINavigationController *)del.deck.centerController;
            
            //Pop
            [nav popViewControllerAnimated:YES];
            
            //Refresh all previous screens in the chain
            for (UIViewController *c in nav.viewControllers) {
                if ([c isKindOfClass:[BaseViewController class]]) {
                    BaseViewController *bvc = (BaseViewController *)c;
                    [NSThread detachNewThreadSelector:@selector(refreshScreen) toTarget:bvc withObject:nil];
                }
            }
        }
    }
}

+ (void) toggleNavigationBarVisibility: (BOOL) show
{
    
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (del.deck != nil)
    {
        if (del.deck.centerController != nil)
        {
            UINavigationController *nav = (UINavigationController *)del.deck.centerController;
            [nav setNavigationBarHidden:!show animated:YES];
            [[UIApplication sharedApplication] setStatusBarHidden:!show withAnimation:UIStatusBarAnimationSlide];
            
            if (nav.visibleViewController != nil) {
                [((BaseViewController*)nav.visibleViewController) adjustViewForNavigationBarVisible:show];
            }
        }
    }
    
}


+ (void) toggleStatusBar: (BOOL) off
{
//    [[UIApplication sharedApplication] setStatusBarHidden:on withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarHidden:off];
  
//    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    UINavigationController *n = nil;
    
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (del.deck != nil)
    {
        if (del.deck.centerController != nil)
        {
            n = (UINavigationController *)del.deck.centerController;
        }
    }
    
    if (n != nil && off) {
        n.navigationBar.frame = CGRectMake(0, 0, n.navigationBar.bounds.size.width, 64);
    }
    
    /*
    if (n != nil)
    {
        n.navigationBar.frame = CGRectMake(0, 0, n.navigationBar.bounds.size.width, 64);
        
          //n.navigationBar.bounds;
   
        [UIView animateWithDuration:0.25 animations:^{
            n.navigationBar.frame = CGRectMake(0, 0, n.navigationBar.bounds.size.width, 64);
            //del.window.frame = CGRectMake(0, 25, appFrame.size.width, appFrame.size.height);
        }];
   
    }
    */

    /*
    [UIView animateWithDuration:0.25 animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:off];
        
        if (n != nil)
        {
            if (off) {
                n.navigationBar.frame = CGRectMake(n.navigationBar.frame.origin.x, n.navigationBar.frame.origin.y, n.navigationBar.frame.size.width, 64);
            }
        }
    }];
     */
}

/*
+ (void) browseToPhoto: (MealPhoto *) photo
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (del.deck != nil)
    {
        if (del.deck.centerController != nil)
        {
            UINavigationController *n = (UINavigationController *)del.deck.centerController;
            
            PhotoDetailsViewController *dtls = [[PhotoDetailsViewController alloc] init];
            dtls.mealPhoto = photo;
            [n pushViewController:dtls animated:YES];
        }
    }
}
*/


@end
