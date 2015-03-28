//
//  Utility_Functions.m
//  Stickies
//
//  Created by Patrick Rills on 6/12/14.
//  Copyright (c) 2014 Think Tank. All rights reserved.
//

#import "Utility_Functions.h"

@implementation Utility_Functions

+ (NSString *) getDefaultSetting: (NSString *)key
{
	NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:key];
	if (value == nil)
	{
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"defaults" ofType:@"plist"];
		NSDictionary *defaultsDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
		[[NSUserDefaults standardUserDefaults] registerDefaults:defaultsDict];
	}
	
	return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (UIColor *) getPrimaryColor
{
	return [Utility_Functions getSystemColor: @"primaryColor"];
}

+ (UIColor *) getSystemColor: (NSString *)name
{
	return [Utility_Functions parseColor:[Utility_Functions getDefaultSetting: name]];
}


+ (UIColor *) parseColor: (NSString *)values
{
	NSArray *split = [values componentsSeparatedByString:@","];
	CGFloat red = [(NSString *)[split objectAtIndex:0] intValue];
	CGFloat green = [(NSString *)[split objectAtIndex:1] intValue];
	CGFloat blue = [(NSString *)[split objectAtIndex:2] intValue];
	return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

+ (NSString *) colorToString: (UIColor *) c
{
    CGColorRef color = [c CGColor];
    unsigned long numComponents = CGColorGetNumberOfComponents(color);
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(color);
        CGFloat red = components[0];
        CGFloat green = components[1];
        CGFloat blue = components[2];
        
        NSLog(@"%d,%d,%d", (int)ceil(red*255.0), (int)ceil(green*255.0), (int)ceil(blue*255.0));
        
        return [NSString stringWithFormat:@"%d,%d,%d", (int)ceil(red*255.0), (int)ceil(green*255.0), (int)ceil(blue*255.0)];
    }
    
    return nil;
}

+ (NSString *) createGUID
{
	CFUUIDRef uuidObj = CFUUIDCreate(nil);
	NSString *uuidString = (__bridge NSString *)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return [uuidString lowercaseString];
}

+ (NSString *) getPath: (NSString *)key
{
	NSString *currFolder = [Utility_Functions getDefaultSetting:key];
	NSArray *allPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *subDir = [[allPaths objectAtIndex:0] stringByAppendingPathComponent:currFolder];
	BOOL isFolder = YES;
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:subDir isDirectory:&isFolder]) {
		[[NSFileManager defaultManager] createDirectoryAtPath:subDir withIntermediateDirectories: NO attributes: nil error: nil];
	}
	
	return subDir;
}

@end
