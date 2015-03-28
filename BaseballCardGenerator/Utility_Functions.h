//
//  Utility_Functions.h
//  Stickies
//
//  Created by Patrick Rills on 6/12/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility_Functions : NSObject

+ (NSString *) getDefaultSetting: (NSString *)key;
+ (UIColor *) getPrimaryColor;
+ (UIColor *) getSystemColor: (NSString *)name;
+ (UIColor *) parseColor: (NSString *)values;
+ (NSString *) colorToString: (UIColor *) c;
+ (NSString *) createGUID;
+ (NSString *) getPath: (NSString *)key;

@end
