//
//  BrightnessControl.m
//  osdui
//
//  Created by m00nbek Melikulov on 1/9/23.
//

#import "BrightnessControl.h"
#import "CoreGraphics/CoreGraphics.h"

#define kMaxDisplays        16
#define kDisplayBrightness    (CFSTR(kIODisplayBrightnessKey))

@implementation BrightnessControl

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

+ (float)getBrightnessLevel
{
    float ret;
    CGDirectDisplayID display[kMaxDisplays];
    CGDisplayCount numDisplays;

    CGDisplayErr err = CGGetActiveDisplayList(kMaxDisplays, display, &numDisplays);
    if (err != CGDisplayNoErr)
    {
        NSLog(@"[ERR] Cannot get list of displays (%i)\n", err);
        return kBrightnessControlMaxValue;
    }

    for (CGDisplayCount i = 0; i < numDisplays; i++)
    {
        CGDirectDisplayID dspy = display[i];
        CGDisplayModeRef originalMode = CGDisplayCopyDisplayMode(dspy);
        if (!originalMode)
            continue ;
        CGDisplayModeRelease(originalMode);
        io_service_t service = CGDisplayIOServicePort(dspy); // deprecated

        err = IODisplayGetFloatParameter(service, kNilOptions, kDisplayBrightness, &ret);
        if (err == kIOReturnSuccess)
            return ret;
        NSLog(@"[ERR] Failed to get brightness of display %#0x (%i)", (unsigned int)dspy, err);
    }

    NSLog(@"[ERR] Couldn't get brightness for any display!");
    return kBrightnessControlMaxValue;
}

+ (void)setBrightnessLevel:(float)level
{
    CGDirectDisplayID display[kMaxDisplays];
    CGDisplayCount numDisplays;

    CGDisplayErr err = CGGetActiveDisplayList(kMaxDisplays, display, &numDisplays);
    if (err != CGDisplayNoErr)
    {
        NSLog(@"[ERR] Cannot get list of displays (%i)\n", err);
        return ;
    }

    for (CGDisplayCount i = 0; i < numDisplays; i++)
    {
        CGDirectDisplayID dspy = display[i];
        CGDisplayModeRef originalMode = CGDisplayCopyDisplayMode(dspy);
        if (!originalMode)
            continue ;
        CGDisplayModeRelease(originalMode);
        io_service_t service = CGDisplayIOServicePort(dspy); // deprecated

        err = IODisplaySetFloatParameter(service, kNilOptions, kDisplayBrightness, level);
        if (err != kIOReturnSuccess)
            NSLog(@"[ERR] Failed to set brightness of display %#0x (%i)", (unsigned int)dspy, err);
    }
}

#pragma GCC diagnostic pop

@end

