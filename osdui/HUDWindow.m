//
//  HUDWindow.m
//  osdui
//
//  Created by m00nbek Melikulov on 1/9/23.
//
//

#import "HUDWindow.h"

@implementation HUDWindow

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)backingStoreType defer:(BOOL)flag
{
    self = [super initWithContentRect:contentRect styleMask:style backing:backingStoreType defer:flag];
    if (self)
    {
        self.styleMask |= NSWindowStyleMaskBorderless;
        [self setOpaque:NO];
        [self setBackgroundColor:[NSColor clearColor]];
        if (@available(macOS 10.9, *))
            [self setAppearance:[NSAppearance appearanceNamed:NSAppearanceNameAqua]];
    }
    return self;
}

- (void)setContentView:(__kindof NSView *)contentView
{
    [contentView setWantsLayer:YES];
    [contentView.layer setCornerRadius:12.0f];
    [contentView.layer setBackgroundColor:[NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:0.75].CGColor];

    [super setContentView:contentView];
}

@end
