//
//  AppDelegate.m
//  osdui
//
//  Created by m00nbek Melikulov on 1/9/23.
//

#import "AppDelegate.h"
#import "NSAppSubclass.h"
#import "OSDUIHelper.h"

#import "VolumeControl.h"
#import <AppKit/NSEvent.h>
#import <AudioToolbox/AudioServices.h>
#define kVolumeKey @"currentvolumeforvolumemonitorkey"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _hudCtrl = [[HUDWindowController alloc] initWithWindowNibName:@"HUDWindow"];
    [_hudCtrl loadWindow];

#ifdef DEBUG
    [(NSAppSubclass *)NSApp setHudCtrl:_hudCtrl];
#else
    _listener = [[NSXPCListener alloc] initWithMachServiceName:@"com.apple.OSDUIHelper"];
    [_listener setDelegate:self];
    [_listener resume];
#endif
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
    ^{
        [[NSUserDefaults standardUserDefaults] setFloat: [[VolumeControl class] volume] forKey: kVolumeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        for(CGFloat volLevel = [[VolumeControl class] volume];; volLevel = [[VolumeControl class] volume])
        {
             if (volLevel != [[NSUserDefaults standardUserDefaults] floatForKey: kVolumeKey])
             {
                 [[NSUserDefaults standardUserDefaults] setFloat: [[VolumeControl class] volume] forKey: kVolumeKey];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 dispatch_async(dispatch_get_main_queue(),
                 ^{
                     [self volumeDidChangeToLevel: volLevel];
                 });
             }
        }
    });

}

- (void)volumeDidChangeToLevel: (CGFloat)level
{
//    NSLog(@"LEVEL: %f", level);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (level > 0) {
            [self->_hudCtrl showHUDForAction:kBezelActionVolume sliderFilled:level sliderMax:1.0f textStringValue:nil];
        } else {
            [self->_hudCtrl showHUDForAction:kBezelActionMute sliderFilled:level sliderMax:1.0f textStringValue:nil];
        }
    });
}

#pragma mark - XPC Delegate (10.12+)

#ifndef DEBUG

- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection
{
#pragma unused(listener)

    [newConnection setExportedInterface:[NSXPCInterface interfaceWithProtocol:@protocol(OSDUIHelperProtocol)]];
    [newConnection setExportedObject:self];

    [newConnection resume];

    return YES;
}

#pragma mark - OSDUIHelper Protocol (10.12+)

- (void)showImage:(long long)img onDisplayID:(CGDirectDisplayID)did priority:(unsigned int)prio msecUntilFade:(unsigned int)msec filledChiclets:(unsigned int)filled totalChiclets:(unsigned int)total locked:(int8_t)locked
{
#pragma unused(did, prio, msec)

    bezel_action_t action = kBezelActionUndef;
    switch (img)
    {
        case 4:
            action = kBezelActionMute;
            break ;
        case 5:
        case 23:
            action = kBezelActionVolume;
            break ;
        case 1:
            action = kBezelActionBrightness;
            break ;
        case 25:
            action = kBezelActionKeyBrightness;
            break ;
        case 26: // old keyboards (2007-): kbBright off key; new keyboards: kbBright = 0
        case 28: // disabled (too much light detected by ALS)
            action = kBezelActionKeyBrightnessOff;
            break ;
    }
    if (action == kBezelActionUndef)
        return ;

    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_hudCtrl showHUDForAction:action sliderFilled:filled sliderMax:locked ? 0.0f : total textStringValue:nil];
    });
}

#endif

@end
