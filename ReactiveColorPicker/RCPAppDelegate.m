//
//  RCPAppDelegate.m
//  ReactiveColorPicker
//
//  Created by Mikael Hallendal on 2013-02-16.
//  Copyright (c) 2013 Mikael Hallendal. All rights reserved.
//

#import "RCPAppDelegate.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RCPView.h"

@implementation RCPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [RACAble(self.colorPickerView.color) subscribeNext:^(id x) {
        NSLog(@"Color changes %@", x);
    }];
}

@end
