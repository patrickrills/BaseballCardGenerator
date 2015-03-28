//
//  JSONDataParser.m
//  Food Truck Tracker
//
//  Created by Patrick Rills on 12/15/13.
//  Copyright (c) 2013 Food Truck Tracker. All rights reserved.
//

#import "JSONDataParser.h"
#import "JSONObject.h"
#import "Utility_Functions.h"

@implementation JSONDataParser

@synthesize returnType, responseData; //, completionObject;

- (void) getObjects: (APIRequest *) apiRequest completion: (completionBlock) onCompletion
{
    self.returnType = apiRequest.returnType;
    self.responseData = [[NSMutableData alloc] init];
    self.completeBlock = onCompletion;
    self.responseCode = -1;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[apiRequest buildURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:[[Utility_Functions getDefaultSetting:@"connectionTimeout"] floatValue]];
    [request setValue:@"application/json,text/plain" forHTTPHeaderField:@"accept"];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(!conn) {
        NSLog(@"Error with connection");
        [self performSelector:@selector(errorCompletion) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    }
}

// delegate
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
    NSLog(@"%ld", (long)((NSHTTPURLResponse *)response).statusCode);
    [self.responseData setLength:0];
    self.responseCode = (int)((NSHTTPURLResponse *)response).statusCode;
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
    NSLog(@"didReceiveData Received %lu bytes of data",(unsigned long)[data length]);
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
    NSLog(@"Connection failed: %@", [error description]);
    
    [self performSelector:@selector(errorCompletion) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[self.responseData length]);
    
    NSError *myError = nil;
    NSMutableArray *retrieved = nil;
    
    if (self.responseData != nil) {
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
        
        if(res != nil) {
            BOOL multiItems = NO;
            for(id t in res) {
                if([t isKindOfClass:[NSDictionary class]]) {
                    multiItems = YES;
                    //NSLog(@"NSDICT: %@", t);
                    if(![t isKindOfClass:[NSNull class]]) {
                        JSONObject *temp = [(JSONObject *)[self.returnType alloc] initWithJSON:t];
                        if(retrieved == nil) {
                            retrieved = [[NSMutableArray alloc] init];
                        }
                        [retrieved addObject:temp];
                    }
                }
            }
            
            if(!multiItems) {
                if(res.count > 0) {
                    JSONObject *temp = [(JSONObject *)[self.returnType alloc] initWithJSON:res];
                    retrieved = [NSMutableArray arrayWithObject:temp];
                }
            }
        }
    } else {
        if (self.responseCode != 200) {
            [self performSelector:@selector(errorCompletion) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
            return;
        }
    }
    
    [self performSelector:@selector(successfullyCallCompletion:) onThread:[NSThread mainThread] withObject:retrieved waitUntilDone:NO];
}

- (void) successfullyCallCompletion: (NSMutableArray *) objs
{
    self.completeBlock(NO, objs);
}

- (void) errorCompletion
{
    self.completeBlock(YES, nil);
}

- (void) postObjects: (NSData *) JSONobjs toURL: (APIRequest *) apiRequest  completion: (completionBlock) onCompletion
{
    self.completeBlock = onCompletion;
    self.returnType = apiRequest.returnType;
    self.responseData = [[NSMutableData alloc] init];
    self.responseCode = -1;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[apiRequest buildURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:[[Utility_Functions getDefaultSetting:@"connectionTimeout"] floatValue]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"%@", [NSString stringWithUTF8String:[JSONobjs bytes]]);
    
    [request setValue:[NSString stringWithFormat:@"%ld", (long)[JSONobjs length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: JSONobjs];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(!conn) {
        NSLog(@"Error with connection");
	    [self performSelector:@selector(errorCompletion) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    }
}

@end
