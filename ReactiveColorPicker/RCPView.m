//
//  RCPView.m
//  ReactiveColorPicker
//
//  Created by Mikael Hallendal on 2013-02-16.
//  Copyright (c) 2013 Mikael Hallendal. All rights reserved.
//

#import "RCPView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RCPView ()
@property(assign) IBOutlet NSSlider *redSlider;
@property(assign) IBOutlet NSSlider *greenSlider;
@property(assign) IBOutlet NSSlider *blueSlider;
@property(assign) IBOutlet NSTextField *redValueLabel;
@property(assign) IBOutlet NSTextField *greenValueLabel;
@property(assign) IBOutlet NSTextField *blueValueLabel;
@property(assign) IBOutlet NSTextField *redLabel;
@property(assign) IBOutlet NSTextField *greenLabel;
@property(assign) IBOutlet NSTextField *blueLabel;

@property(nonatomic) CGFloat red;
@property(nonatomic) CGFloat green;
@property(nonatomic) CGFloat blue;

@property(nonatomic, strong, readwrite) NSColor *color;
@end

@implementation RCPView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _red = _green = _blue = 0.5;
        
        self.wantsLayer = YES;
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self.redSlider   rac_bind:@"value" toObject:self withKeyPath:@"red"];
    [self.greenSlider rac_bind:@"value" toObject:self withKeyPath:@"green"];
    [self.blueSlider  rac_bind:@"value" toObject:self withKeyPath:@"blue"];
    
    // Calculate the color
    RAC(self.color) = [RACSignal
                       combineLatest:@[RACAbleWithStart(self.red), RACAbleWithStart(self.green), RACAbleWithStart(self.blue)]
                       reduce:^(NSNumber *red, NSNumber *green, NSNumber *blue) {
                           return [NSColor colorWithCalibratedRed:[red floatValue]
                                                            green:[green floatValue]
                                                             blue:[blue floatValue]
                                                            alpha:1.0];
                       }];

    
    // Bind the color component values to their respective labels
    id colorComponentToInt = ^id(id value) { return @([value floatValue] * 255); };
    
    RAC(self.redValueLabel.intValue)   = [RACAbleWithStart(self.red)   map:colorComponentToInt];
    RAC(self.greenValueLabel.intValue) = [RACAbleWithStart(self.green) map:colorComponentToInt];
    RAC(self.blueValueLabel.intValue)  = [RACAbleWithStart(self.blue)  map:colorComponentToInt];
    
    
    // Update the text color based on the color
    RACSignal *textColor = [RACAble(self.color) map:^id(NSColor *color) {
        CGFloat gray = 0.299 * color.redComponent + 0.587 * color.greenComponent + 0.114 * color.blueComponent;
        return gray > 0.5 ? [NSColor blackColor] : [NSColor whiteColor];
    }];
    
    [@[self.redLabel, self.redValueLabel, self.greenLabel, self.greenValueLabel, self.blueLabel, self.blueValueLabel]
     enumerateObjectsUsingBlock:^(NSTextField *tf, NSUInteger idx, BOOL *stop) {
         RAC(tf, textColor) = textColor;
     }];
    
    
    // Change the color of the background
    __weak __typeof(self) weakSelf = self;
    [RACAble(self.color) subscribeNext:^(NSColor *color) {
        weakSelf.layer.backgroundColor = color.CGColor;
    }];
}

@end
