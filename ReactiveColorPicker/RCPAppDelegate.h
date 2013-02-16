//
//  RCPAppDelegate.h
//  ReactiveColorPicker
//
//  Created by Mikael Hallendal on 2013-02-16.
//  Copyright (c) 2013 Mikael Hallendal. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class RCPView;

@interface RCPAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet RCPView *colorPickerView;
@end
