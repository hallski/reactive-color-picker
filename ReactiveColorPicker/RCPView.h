//
//  RCPView.h
//  ReactiveColorPicker
//
//  Created by Mikael Hallendal on 2013-02-16.
//  Copyright (c) 2013 Mikael Hallendal. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RCPView : NSView
@property(nonatomic, strong, readonly) NSColor *color;
@end
