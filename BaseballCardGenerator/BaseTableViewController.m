//
//  BaseTableViewController.m
//  Stickies
//
//  Created by Patrick Rills on 6/12/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UI_Functions.h"
#import "Utility_Functions.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (UITableViewStyle) tableStyle
{
    //default
    return UITableViewStylePlain;
}

- (void)loadView
{
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:[self tableStyle]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self registerCellsForTableView:self.tableView];
    self.view = self.tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Must override
    return nil;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //must override
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (void) scrollToFirstCell
{
    if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] != nil) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void) addTextboxToCell: (UITableViewCell *) cell withTag: (long) tag andLabel: (NSString *) lbl andValue: (NSString *) val
{
    [self addTextboxToCell:cell withTag:tag andLabel:lbl andValue:val withKeyboardType:UIKeyboardTypeDefault];
}

- (void) addTextboxToCell: (UITableViewCell *) cell withTag: (long) tag andLabel: (NSString *) lbl andValue: (NSString *) val withKeyboardType: (UIKeyboardType) keyType
{
    UITextField *txt = nil;
    
    //get previous textbox if exists
    for (UIView *t in cell.contentView.subviews) {
        if ([t isKindOfClass:[UITextField class]]) {
            txt = (UITextField *)t;
        }
    }
    
    if (txt == nil) {
        txt = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, cell.contentView.frame.size.width * 0.97, 26)];
        txt.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addHelperToTextBox:txt];
    }
    
    txt.borderStyle = UITextBorderStyleNone;
    txt.tag = tag;
    txt.placeholder = lbl;
    txt.clearButtonMode = UITextFieldViewModeWhileEditing;
    txt.text = val;
    txt.autocorrectionType = UITextAutocorrectionTypeNo;
    txt.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //txt.textAlignment = NSTextAlignmentRight;
    txt.textAlignment = NSTextAlignmentLeft;
    txt.keyboardType = keyType;
    
    if (keyType != UIKeyboardTypeDefault) {
        txt.textColor = [Utility_Functions getPrimaryColor];
    } else {
        txt.textColor = [UIColor darkTextColor];
    }
    
    if ([lbl hasPrefix:@"Password"] || [lbl hasSuffix:@"Password"]) {
        txt.secureTextEntry = YES;
    }
    
    //add events
    [txt addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [txt addTarget:self action:@selector(textFocused:) forControlEvents:UIControlEventEditingDidBegin];
    [txt addTarget:self action:@selector(textEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    [cell.contentView addSubview:txt];
}

- (void) addHelperToTextBox: (UITextField *) txt
{
    if ([UI_Functions isPhone]) {
        if (self.keyboardHelper == nil) {
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleDefault;
            numberToolbar.tintColor = [Utility_Functions getPrimaryColor];
            //numberToolbar.items = [NSArray arrayWithObjects:
            //                       [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(goToNextTextbox:)],
                   //                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target :nil action:nil],
                   //                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithKeyboard:)],
                   //                nil];
            
            numberToolbar.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithKeyboard:)],
                                   nil];
            
            [numberToolbar sizeToFit];
            self.keyboardHelper = numberToolbar;
        }
        
        
        txt.inputAccessoryView = self.keyboardHelper;
    }
}

- (IBAction)doneWithKeyboard:(id)sender
{
    self.keyboardIsOut = NO;
    [self.tableView endEditing:YES];
}

- (IBAction)goToNextTextbox:(id)sender
{
    UITextField *t = [self nextTextBox];
    if (t != nil) {
        self.keyboardIsOut = NO;
        [t becomeFirstResponder];
    }
}

- (UITextField *) nextTextBox
{
    if (self.keyboardHelper != nil) {
        for (UITableViewCell *c in self.tableView.visibleCells) {
            NSIndexPath *i = [self.tableView indexPathForCell:c];
            if (i.section == 0) {
                if (i.row > self.textBoxWithFocus) {
                    for (UIView *s in c.contentView.subviews) {
                        if ([s isKindOfClass:[UITextField class]]) {
                            return (UITextField *)s;
                        }
                    }
                }
            }
        }
    }
    
    return nil;
}

- (IBAction)textChanged:(id)sender
{
    UITextField *t = (UITextField *)sender;
    long row = t.tag;
    [self cellTextBoxValueChanged:t forRowNumber:row];
}

- (IBAction)textEndEditing:(id)sender
{
    UITextField *t = (UITextField *)sender;
    long row = t.tag;
    [self cellTextBoxFinishedEditing:t forRowNumber:row];
}

- (void) cellTextBoxValueChanged:(UITextField *)txt forRowNumber:(long)row
{
    //must override
    NSLog(@"Base class");
}

- (void) cellTextBoxFinishedEditing: (UITextField *) txt forRowNumber: (long) row
{
    //must override
    NSLog(@"Base class");
}

- (IBAction)textFocused:(id)sender
{
    UITextField *t = (UITextField *)sender;
    int section = 0;
    long row = t.tag;
    
    self.textBoxWithFocus = row;
    
    if (!self.keyboardIsOut) {
        self.keyboardIsOut = YES;
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:row inSection:section] atScrollPosition:UITableViewScrollPositionMiddle animated:![UI_Functions isPhone]];
        
        if (self.keyboardHelper != nil && row >= 6) {
            float additionalFactor = 1.0;
            if ([UI_Functions isShortPhone]) {
                additionalFactor = 2.0;
            }
            
            CGPoint o = self.tableView.contentOffset;
            o.y = o.y + (self.keyboardHelper.frame.size.height * additionalFactor);
            self.tableView.contentOffset = o;
        }
    }
    
}

- (void) updateUI
{
    [self.tableView reloadData];
    [UI_Functions hideLoading];
}


@end
