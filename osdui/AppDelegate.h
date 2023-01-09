//
//  AppDelegate.h
//  osdui
//
//  Created by m00nbek Melikulov on 1/9/23.
//  
//

#import <Cocoa/Cocoa.h>
#import "HUDWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSXPCListenerDelegate>
{
    HUDWindowController *_hudCtrl;
    NSXPCListener *_listener;
}

@end
