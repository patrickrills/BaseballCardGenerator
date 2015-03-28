//
//  JSONObject.m
//  Food Truck Tracker
//
//  Created by Patrick Rills on 12/15/13.
//  Copyright (c) 2013 Food Truck Tracker. All rights reserved.
//

#import "JSONObject.h"
#import <objc/runtime.h>

@implementation JSONObject

- (id) initWithJSON: (NSDictionary *) dict {
    self = [super init];
    if (self) {
        [self initializeWithValues:dict];
    }
    return self;
}

- (void) initializeWithValues: (NSDictionary *) dict
{
    //match dictionary names to properties
	unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
		
		for (int k = 0; k < [[dict allKeys] count]; k++)
		{
			NSString *currentKey = (NSString *)[[dict allKeys] objectAtIndex:k];
			if ([[currentKey lowercaseString] isEqualToString:[propertyName lowercaseString]]) {
				id val = [dict objectForKey:currentKey];
				if (val == [NSNull null])
				{
					val = @"";
				}
				
				[self setValue: val forKey:propertyName];
			}
		}
    }
    free(properties);
}

- (NSDictionary *) toJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        
        if (![propertyValue isKindOfClass:[NSMutableArray class]]) {
            if (propertyValue == nil) {
                [dict setObject:@"" forKey:(NSString *)propertyName];
            } else {
                [dict setObject:propertyValue forKey:(NSString *)propertyName];
            }
        }
    }
    free(properties);
    
    return dict;
}

- (NSData *) toJSONData
{
    return [self convertJSON:[self toJSON]];
}

- (NSData *) convertJSON: (NSDictionary *) dict
{
    NSError *err;
    NSData *j = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
    if (err == nil) {
        //NSLog(@"data: %@", [[NSString alloc] initWithData:j encoding:NSUTF8StringEncoding]);
        return j;
    }
    
    return nil;
}

- (NSMutableArray *) convertChildArrayToClass: (Class) c withValues: (NSObject *) child
{
    //This method will convert an NSArray of NSDictionary(s) (a JSON array) to a mutable array of strongly typed NSObject(s)
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    if (child != nil && child != [NSNull null] && [child isKindOfClass:[NSArray class]]) {
        for (NSDictionary *d in (NSArray *)child) {
            JSONObject *x = [(JSONObject *)[c alloc] initWithJSON:d];
            [arr addObject:x];
        }
    }
    
    return arr;
}

@end
