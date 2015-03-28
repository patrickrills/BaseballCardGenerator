//
//  PlayerListViewController.m
//  BaseballCardGenerator
//
//  Created by Patrick Rills on 3/28/15.
//  Copyright (c) 2015 BaseballHackDay. All rights reserved.
//

#import "PlayerListViewController.h"
#import "PlayerCard.h"
#import "Card_Functions.h"
#import "UI_Functions.h"
#import "CardViewController.h"

@interface PlayerListViewController ()

@end

@implementation PlayerListViewController

- (ScreenType) screenType
{
    return PlayerListScreen;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    NSString *name = @"Anthony Ranaudo";
    if (indexPath.row == 0)
        name = @"Russell Martin";
    
    cell.textLabel.text = name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [UI_Functions showLoading];
            [Card_Functions getPlayerWithId:@"3da24e28-741c-4978-bdba-52de51975820" onComplete:^(PlayerCard *c) {
                [UI_Functions hideLoading];
                CardViewController *cvc = [[CardViewController alloc] init];
                cvc.currentCard = c;
                [self.navigationController pushViewController:cvc animated:YES];
            }];
            break;
        }
        case 1:
        {
            CardViewController *cvc = [[CardViewController alloc] init];
            cvc.currentCard = [Card_Functions getTestPlayerCard];
            [self.navigationController pushViewController:cvc animated:YES];
            break;
        }
            
        default:
            break;
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
