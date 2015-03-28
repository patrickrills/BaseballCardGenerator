//
//  BaseTableViewController.h
//  Stickies
//
//  Created by Patrick Rills on 6/12/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIToolbar *keyboardHelper;
@property BOOL keyboardIsOut;
@property long textBoxWithFocus;

- (void) scrollToFirstCell;
- (UITableViewStyle) tableStyle;
- (void) addTextboxToCell: (UITableViewCell *) cell withTag: (long) tag andLabel: (NSString *) lbl andValue: (NSString *) val;
- (void) addTextboxToCell: (UITableViewCell *) cell withTag: (long) tag andLabel: (NSString *) lbl andValue: (NSString *) val withKeyboardType: (UIKeyboardType) keyType;
- (void) cellTextBoxValueChanged: (UITextField *) txt forRowNumber: (long) row;
- (void) cellTextBoxFinishedEditing: (UITextField *) txt forRowNumber: (long) row;
- (void) updateUI;

@end
