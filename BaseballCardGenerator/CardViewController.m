//
//  CardViewController.m
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "CardViewController.h"
#import "Card_Functions.h"
#import "UI_Functions.h"
#import "PaintCodeButton.h"

@interface CardViewController ()

@end

@implementation CardViewController

- (ScreenType) screenType
{
    return PlayerCardScreen;
}

- (void) initializeUI
{    
    [UI_Functions toggleNavigationBarVisibility:NO];
    [UI_Functions toggleStatusBar:YES];
    
    if (self.currentCard != nil)
    {
        if (self.front == nil)
        {
            CardBack *b = [[CardBack alloc] initWithFrame:self.view.frame andURL:self.currentCard.backURL];
            [self.view addSubview:b];
            self.back = b;
            [self.back refresh];
            self.back.hidden = YES;
            
            CardFront *f = [[CardFront alloc] initWithFrame:self.view.frame andHistory:self.currentCard.teamHistory];
            [self.view addSubview:f];
            self.front = f;
            self.front.hidden = NO;
        }
        
        if (self.name == nil)
        {
            Nameplate *n = [[Nameplate alloc] initWithFrame:CGRectMake(-1, self.view.frame.size.height - 90.0, self.view.frame.size.width + 2, 70.0) andName:self.currentCard.name andPosition:self.currentCard.positionLong];
            [self.view addSubview:n];
            self.name = n;
        }
    }
    
    PaintCodeButton *b = [PaintCodeButton buttonWithType:CardCorner andFrame:CGRectMake(self.view.frame.size.width - 50.0, 0, 50.0, 50.0)];
    [b addTarget:self action:@selector(flipCard:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
}

- (IBAction)flipCard:(id)sender
{
 
    BOOL frontHidden = !self.front.hidden;
    
    [UIView transitionWithView:self.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ self.front.hidden = frontHidden; self.back.hidden = !frontHidden; }
                    completion:^(BOOL completed) {
                        self.name.hidden = self.front.hidden;
                    }];
    
    
}

@end
