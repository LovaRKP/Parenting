//
//  GoogleWeb.m
//  ZenParent
//
//  Created by Techno on 9/7/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "GoogleWeb.h"

@implementation GoogleWeb


- (BOOL)openURL:(NSURL*)url {
    
    NSURL *googlePlusURL = [[NSURL alloc] initWithString:@"gplus://plus.google.com/"];
    
    BOOL hasGPPlusAppInstalled = [[UIApplication sharedApplication] canOpenURL:googlePlusURL];
    
    
    if(!hasGPPlusAppInstalled)
    {
        if ([[url absoluteString] hasPrefix:@"googlechrome-x-callback:"]) {
            
            return NO;
            
        } else if ([[url absoluteString] hasPrefix:@"https://accounts.google.com/o/oauth2/auth"]) {
            
        
            
            NSLog(@"url:   %@",url);
            // Post a notification to loginComplete
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginComplete" object:url];

            return NO;
            
        }else if ([[url absoluteString] hasPrefix:@"https://accounts.google.com/o/oauth2/auth"]) {
            
            
            
            NSLog(@"url:   %@",url);
            // Post a notification to loginComplete
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginComplete" object:url];
            
            return NO;
            
        }

    }
    
    
    return [super openURL:url];
}

@end
