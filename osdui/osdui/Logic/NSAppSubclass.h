//
//  NSAppSubclass.h
//  osdui
//
//  Created by m00nbek Melikulov on 1/9/23.
//

#import <Cocoa/Cocoa.h>

@class HUDWindowController;

@interface NSAppSubclass : NSApplication

@property (readwrite) HUDWindowController *hudCtrl;

@end
