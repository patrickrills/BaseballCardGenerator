//
//  MainMenuViewController.m
//  Lose-It-Photo-Prototype
//
//  Created by Patrick Rills on 10/19/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import "MainMenuViewController.h"
#import "PaintCodeMenuCell.h"
#import "BaseViewController.h"
#import "UI_Functions.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    self.tableView.separatorColor = [UIColor clearColor];
    
    //Return empty view so that cell separators don't show for unused cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //[self.tableView registerNib:[UINib nibWithNibName:@"PaintCodeMenuCell" bundle:nil] forCellReuseIdentifier:@"PaintCodeMenuCell"];
}

- (void) refreshMenu
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PaintCodeMenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PaintCodeMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.section == 0) {
        [(PaintCodeMenuCell *)cell setMenuIconForItem:(MenuItem)indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            
            switch ((MenuItem)indexPath.row) {
                case AboutApp:
                    [UI_Functions browseToScreen:About];
                    break;
                case ImagesSummary:
                    [UI_Functions browseToScreen:Summary];
                    break;
                case ImagesByDay:
                    [UI_Functions browseToScreen:Today];
                    break;
                case StoriesList:
                    [UI_Functions browseToScreen:Stories];
                    break;
                default:
                    break;
            }
            
            
            break;
        }
        default:
            break;
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
